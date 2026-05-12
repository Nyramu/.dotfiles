{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages.screen-shot = pkgs.writeShellApplication {
        name = "screen-shot";

        runtimeInputs = with pkgs; [
          grim
          slurp
          wl-clipboard
          maim
          xclip
        ];

        text =
          # bash
          ''
            readonly OUTPUT_DIR="''${XDG_SCREENSHOTS_DIR:-$HOME/Pictures/Screenshots}"

            if [ -z "$XDG_SESSION_TYPE" ]; then
              echo "XDG_SESSION_TYPE is not set, aborting" >&2
              exit 1
            fi

            save_file=false
            if [ "''${1:-}" = "--save" ]; then
              save_file=true
            fi

            mkdir -p "$OUTPUT_DIR"
            file_name="$OUTPUT_DIR/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

            if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
              if ! selection=$(slurp 2>/dev/null); then
                exit 0
              fi
              grim -g "$selection" "$file_name"
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
      };
    };
}
