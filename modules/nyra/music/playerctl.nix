{ self, lib, ... }:
{
  flake.modules.homeManager = {
    music.imports = [ self.modules.homeManager.playerctl ];

    playerctl =
      {
        config,
        nyralib,
        pkgs,
        ...
      }:

      let
        cfg = config.nyra.music.playerctl;

        # Implement whitelist in playerctl management
        playerctl-wl = pkgs.writeShellApplication {
          name = "playerctl";
          runtimeInputs = [ pkgs.playerctl ];
          text = ''
            state="''${XDG_RUNTIME_DIR:-/tmp}/playerctl-wl"
            players="mpd spotify"

            status() {
                timeout 0.15 playerctl -p "$1" status 2>/dev/null
            }

            order="$players"
            if [ -f "$state" ]; then
                order="$(cat "$state") $players"
            fi

            running=""
            seen=""
            for p in $order; do
                case " $seen " in *" $p "*) continue ;; esac
                seen="$seen $p"

                s=$(status "$p") && rc=0 || rc=$?
                if [ "$rc" -eq 0 ]; then
                    [ -z "$running" ] && running="$p"
                    if [ "$s" = "Playing" ]; then
                        printf '%s' "$p" > "$state"
                        exec playerctl -p "$p" "$@"
                    fi
                fi
            done

            if [ -n "$running" ]; then
                printf '%s' "$running" > "$state"
                exec playerctl -p "$running" "$@"
            fi

            exit 1
          '';
        };
      in
      {
        options.nyra.music.playerctl = {
          enable = nyralib.mkDependentOptionFromAny "Playerctl" [
            "nyra.music.mpd.enable"
            "nyra.music.spicetify.enable"
          ];
        };

        config = lib.mkIf (cfg.enable) {
          home.packages = [ playerctl-wl ];

          hyprnix.settings.bind = lib.mkIf (config.nyra.desktops.hyprland.enable) {
            XF86AudioPlay = {
              dispatcher.exec_cmd = "playerctl play-pause";
              flags.locked = true;
            };
            XF86AudioPrev = {
              dispatcher.exec_cmd = "playerctl previous";
              flags.locked = true;
            };
            "SUPER + CTRL + left" = {
              dispatcher.exec_cmd = "playerctl previous";
              flags.locked = true;
            };
            XF86AudioNext = {
              dispatcher.exec_cmd = "playerctl next";
              flags.locked = true;
            };
            "SUPER + CTRL + right" = {
              dispatcher.exec_cmd = "playerctl next";
              flags.locked = true;
            };
          };
        };
      };
  };
}
