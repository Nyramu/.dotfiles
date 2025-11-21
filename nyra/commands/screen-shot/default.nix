{
  writeShellApplication,
  grim,
  slurp,
  wl-clipboard,
  maim,
  xclip,
}:
writeShellApplication {
  name = "screen-shot";

  runtimeInputs = [
    grim
    slurp
    wl-clipboard
    maim
    xclip
  ];

  text =
    # bash
    ''
      if [ -z "$XDG_SESSION_TYPE" ]; then
        echo "XDG_SESSION_TYPE is not set, aborting" >&2
        exit 1
      fi

      save_file=false
      if [ "''${1:-}" = "--save" ]; then
        save_file=true
      fi

      mkdir -p "$HOME/Pictures/"
      file_name="$HOME/Pictures/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

      if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
        slurp | grim -g - "$file_name"
        wl-copy < "$file_name"
        if [ "$save_file" = false ]; then
          rm "$file_name"
        fi
      else
        maim -s "$file_name"
        xclip -selection clipboard -t image/png -i "$file_name" 2>/dev/null || true
        if [ "$save_file" = false ]; then
          rm "$file_name"
        fi
      fi
    '';
}
