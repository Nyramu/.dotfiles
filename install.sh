#!/usr/bin/env bash
set -e

HOSTS_DIR=modules/hosts
FLAKE_DIR=~/.dotfiles
NIX_EXTRA_FEATURES="nix-command flakes pipe-operators"

UI_WIDTH=64
UI_PAD_H=2
UI_MARGIN_SECTION="1 0 0 0"
UI_MARGIN_TIGHT="0 0 0 0"

C_ACCENT=197
C_SUCCESS=42
C_WARN=214
C_MUTED=245
C_TEXT=252
C_SKYBLUE=39

UI_OK='+'
UI_WARN='!'
UI_MARK='>'
UI_BULLET='*'

STEP_N=0
STEP_TOTAL=3

theme() {
  export GUM_CHOOSE_CURSOR_FOREGROUND="$C_WARN"
  export GUM_CHOOSE_SELECTED_FOREGROUND="$C_SUCCESS"
  export GUM_CHOOSE_HEADER_FOREGROUND="$C_SKYBLUE"
  export GUM_CONFIRM_PROMPT_FOREGROUND="$C_WARN"
  export GUM_CONFIRM_SELECTED_FOREGROUND="15"
  export GUM_CONFIRM_SELECTED_BACKGROUND="54"
  export GUM_CONFIRM_UNSELECTED_FOREGROUND="$C_MUTED"
  export GUM_SPIN_SPINNER="dot"
  export GUM_SPIN_TITLE_FOREGROUND="$C_ACCENT"
}

ui_ansi() { printf '\033[%sm%s\033[0m' "$1" "$2"; }
ui_faint() { ui_ansi "2" "$1"; }

die() {
  if command -v gum >/dev/null 2>&1; then
    gum log --level error "$1"
  else
    echo "$1" >&2
  fi
  exit 1
}

ui_line() {
  gum style \
    --width "$UI_WIDTH" \
    --padding "0 $UI_PAD_H" \
    --margin "$UI_MARGIN_TIGHT" \
    "$@"
}

ui_section_line() {
  local marker=$1
  shift
  gum style \
    --width "$UI_WIDTH" \
    --padding "0 $UI_PAD_H" \
    --margin "$UI_MARGIN_SECTION" \
    "$(ui_ansi "1;38;5;${C_ACCENT}" "$marker") $*"
}

ui_step() {
  STEP_N=$((STEP_N + 1))
  ui_section_line "$UI_MARK" \
    "$(ui_ansi "1;38;5;${C_ACCENT}" "$STEP_N/$STEP_TOTAL") $(ui_ansi "1;38;5;${C_TEXT}" "$1")"
}

ui_ok() {
  ui_line "$(ui_ansi "38;5;${C_SUCCESS}" "${UI_OK} $1")"
}

ui_warn() {
  ui_line "$(ui_ansi "38;5;${C_WARN}" "${UI_WARN} $1")"
}

ui_info() {
  ui_line "$(ui_ansi "38;5;${C_VIOLET}" "${UI_BULLET} $1")"
}

ui_banner() {
  gum style \
    --border rounded \
    --border-foreground "$C_ACCENT" \
    --width "$UI_WIDTH" \
    --padding "0 $UI_PAD_H" \
    --margin "$UI_MARGIN_SECTION" \
    "$(ui_ansi "1;38;5;${C_ACCENT}" "Nyramu's NixOS dotfiles")" \
    "$(ui_faint "${UI_BULLET} Installation script")"
}

UI_BOX_LINES=8
UI_BOX_HEIGHT=0
UI_BOX_LAST=""

ui_box_label() {
  ui_ansi "38;5;${C_MUTED}" "${UI_MARK} $1"
}

ui_box_line_count() {
  local text=$1
  while [[ $text == *$'\n' ]]; do
    text="${text%$'\n'}"
  done
  if [[ -z $text ]]; then
    echo 0
    return
  fi
  awk 'END {print NR}' <<< "$text"
}

ui_box_paint() {
  local rendered=$1 new_lines seq=""

  [[ $rendered == "$UI_BOX_LAST" ]] && return 0

  new_lines="$(ui_box_line_count "$rendered")"

  seq=$'\033[?25l'
  if ((UI_BOX_HEIGHT > 0)); then
    seq+=$'\033['"${UI_BOX_HEIGHT}"$'A\033[0J'
  fi
  seq+="${rendered}"$'\n'
  seq+=$'\033[?25h'

  if [[ -e /dev/tty ]]; then
    printf '%s' "$seq" >/dev/tty 2>/dev/null || printf '%s' "$seq" >&2
  else
    printf '%s' "$seq" >&2
  fi

  UI_BOX_HEIGHT=$new_lines
  UI_BOX_LAST=$rendered
}

ui_box_read_lines() {
  local log=$1
  local -n _lines=$2
  local -a raw=()

  _lines=()
  [[ -f $log ]] || return 0

  mapfile -t raw < <(
    tr '\r' '\n' <"$log" |
      sed -e 's/[[:space:]]*$//' |
      awk 'NF' |
      tail -n "$UI_BOX_LINES"
  )

  _lines=("${raw[@]}")
}

ui_box_render() {
  local label=$1
  local -n _lines=$2
  local body

  if ((${#_lines[@]} > 0)); then
    body="$(printf '%s\n' "${_lines[@]}")"
    body="${body%$'\n'}"
  else
    body="$(ui_faint 'starting...')"
  fi

  gum style \
    --border rounded \
    --border-foreground "$C_MUTED" \
    --width "$UI_WIDTH" \
    --padding "0 $UI_PAD_H" \
    --margin "$UI_MARGIN_SECTION" \
    --foreground "$C_TEXT" \
    "$(ui_box_label "$label")" \
    "$body"
}

ui_run_boxed() {
  local label=$1
  shift
  local log status=0 pid
  local -a lines=()

  log="$(mktemp)"
  UI_BOX_HEIGHT=0
  UI_BOX_LAST=""

  ui_box_paint "$(ui_box_render "$label" lines)"

  "$@" >"$log" 2>&1 &
  pid=$!

  while kill -0 "$pid" 2>/dev/null; do
    ui_box_read_lines "$log" lines
    ui_box_paint "$(ui_box_render "$label" lines)"
    sleep 0.2
  done

  wait "$pid" || status=$?

  ui_box_read_lines "$log" lines
  ui_box_paint "$(ui_box_render "$label" lines)"

  if ((status != 0)); then
    tail -20 "$log" >&2 || true
  fi
  rm -f "$log"
  return "$status"
}

if ! command -v gum >/dev/null 2>&1; then
  exec nix --extra-experimental-features "nix-command flakes" \
    shell nixpkgs#gum --command "$0" "$@"
fi

theme

ui_banner
ui_line "$(ui_faint "Welcome! This installer will set up your NixOS config.")"
sleep 2

ui_step "System Verification"
if grep -qi nixos /etc/os-release; then
  ui_ok "Running on NixOS"
else
  die "This installer requires NixOS"
fi

ui_step "Host selection"
declare -A hosts=()
for host_dir in "$HOSTS_DIR"/*; do
  h=$(basename "$host_dir")
  hosts["$h"]="$h"
done

host="$(gum choose \
  --header "  ${UI_BULLET} Select host:" \
  --cursor "  ${UI_MARK} " \
  "${!hosts[@]}")" || exit 1
if [[ ! -v hosts["$host"] ]]; then
  die "host ${host} does not exist, aborting"
fi
ui_ok "Selected host: $host"

if gum confirm --default=false --affirmative "Generate" --negative "Skip" \
  " ${UI_BULLET} Do you need to generate hardware-configuration.nix?"; then
  sudo nixos-generate-config --show-hardware-config > modules/hosts/"${host}"/_hardware-configuration.nix
  ui_ok "hardware-configuration.nix generated"
fi

ui_step "Host installation"
ui_info "Installing $host host"

ui_run_boxed "nixos-rebuild switch" \
  sudo nixos-rebuild switch --option extra-experimental-features "$NIX_EXTRA_FEATURES" --flake "$FLAKE_DIR#$host" ||
  die "System part of the $host host failed to install"
ui_ok "System part of the $host host has been installed"

ui_run_boxed "home-manager switch" \
  nix run home-manager/master --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake "$FLAKE_DIR#$host" ||
  die "Home Manager part of the $host host failed to install"
ui_ok "Home Manager part of the $host host has been installed"

ui_ok "Installation finished, you can reboot now"
