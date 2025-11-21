{
  writeShellApplication,
  pipewire,
  pulseaudio,
  jq,
  gpu-screen-recorder,
}:
writeShellApplication {
  name = "screen-record";

  runtimeInputs = [
    pipewire
    pulseaudio
    jq
    gpu-screen-recorder
  ];

  text =
    # bash
    ''
      set -euo pipefail

      readonly STATE_DIR="''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/screen-record"
      readonly OUTPUT_DIR="''${SCREEN_RECORD_DIR:-$HOME/Videos}"
      readonly STATE_FILE="$STATE_DIR/recording.state"

      die() {
        echo "Error: $*" >&2
        exit 1
      }

      is_recording() {
        [ -f "$STATE_FILE" ] || return 1

        while IFS= read -r pid; do
          kill -0 "$pid" 2>/dev/null && return 0
        done < "$STATE_FILE"

        rm -f "$STATE_FILE"
        return 1
      }

      get_audio_source() {
        local sink_name

        # Try to get default sink from PipeWire
        sink_name=$(pw-dump 2>/dev/null | jq -r '
          .[]
          | select(.type == "PipeWire:Interface:Metadata")
          | .metadata[]?
          | select(.key == "default.audio.sink")
          | .value.name
        ' | head -1)

        # Fallback to pactl if PipeWire fails
        if [ -z "$sink_name" ]; then
          sink_name=$(pactl get-default-sink 2>/dev/null)
        fi

        [ -n "$sink_name" ] || return 1

        echo "$sink_name.monitor"
      }

      start_recording() {
        local output
        local audio_source

        output="$OUTPUT_DIR/screenrecord_$(date +%Y-%m-%d-%T).mp4"
        audio_source=$(get_audio_source) || die "Cannot find audio source"

        mkdir -p "$STATE_DIR"

        gpu-screen-recorder \
          -w screen \
          -f 60 \
          -a "$audio_source" \
          -c mp4 \
          -o "$output" &

        echo $! > "$STATE_FILE"
        echo "Recording started: $output"
      }

      stop_recording() {
        local pids
        pids=$(cat "$STATE_FILE")

        for pid in $pids; do
          kill -INT "$pid" 2>/dev/null || true
        done

        for pid in $pids; do
          if kill -0 "$pid" 2>/dev/null; then
            wait "$pid" 2>/dev/null || true
          fi
        done

        rm -f "$STATE_FILE"
        echo "Recording stopped"
      }

      main() {
        mkdir -p "$OUTPUT_DIR" "$STATE_DIR"

        if is_recording; then
          stop_recording
        else
          start_recording
        fi
      }

      main "$@"
    '';
}
