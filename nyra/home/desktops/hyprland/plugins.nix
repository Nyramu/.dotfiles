{ pkgs, ... }:

{
  wayland.windowManager.hyprland.plugins = with pkgs.hyprlandPlugins; [
    hypr-dynamic-cursors
  ];

  wayland.windowManager.hyprland.extraConfig = ''
    plugin:dynamic-cursors {
      enabled = true
      mode = rotate
      threshold = 1

      # for mode = rotate
      rotate {

        # length in px of the simulated stick used to rotate the cursor
        # most realistic if this is your actual cursor size
        length = 30

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
}
