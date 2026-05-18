{ ... }:
{
  flake.modules.homeManager.hyprland =
    {
      config,
      lib,
      pkgs,
      ...
    }:

    let
      cfg = config.nyra.desktops.hyprland.plugins.dynamic-cursors;
    in
    {
      options.nyra.desktops.hyprland.plugins = {
        dynamic-cursors = {
          enable = lib.mkEnableOption "hyprland dynamic-cursors plugin";
          mode = lib.mkOption {
            type = lib.types.enum [
              "rotate"
              "shake"
            ];
            default = "rotate";
          };
        };
      };

      config = lib.mkIf (cfg.enable) {
        hyprnix.plugins = with pkgs.hyprlandPlugins; [
          hypr-dynamic-cursors
        ];

        hyprnix.extraConfig = ''
          plugin:dynamic-cursors {
            enabled = true
            mode = ${cfg.mode}
            threshold = 1

            # for mode = rotate
            rotate {

              # length in px of the simulated stick used to rotate the cursor
              # most realistic if this is your actual cursor size
              length = 36

              # clockwise offset applied to the angle in degrees
              # this will apply to ALL shapes
              offset = 0.0
            }

            shake {
              enabled = false
              ipc = false
            }

            hyprcursor {
              enabled = true
              nearest = true
              resolution = -1
            }
          }
        '';
      };
    };
}
