{
  perSystem =
    { pkgs, ... }:
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

            select_area=false
            save_file=false
            for arg in "''${@}"; do
              case "$arg" in
                --selection) select_area=true ;;
                --save)      save_file=true ;;
              esac
            done

            mkdir -p "$OUTPUT_DIR"
            file_name="$OUTPUT_DIR/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

            if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
              if [ "$select_area" = true ]; then
                if ! selection=$(slurp 2>/dev/null); then
                  exit 0
                fi
                grim -g "$selection" "$file_name"
              else
                grim "$file_name"
              fi
              
              wl-copy < "$file_name"
              
              if [ "$save_file" = false ]; then
                rm "$file_name"
              fi
            else
              if [ "$select_area" = true ]; then
                maim -s "$file_name"
              else
                maim "$file_name"
              fi
              
              xclip -selection clipboard -t image/png -i "$file_name" 2>/dev/null || true
              
              if [ "$save_file" = false ]; then
                rm "$file_name"
              fi
            fi
          '';
      };
    };
}
