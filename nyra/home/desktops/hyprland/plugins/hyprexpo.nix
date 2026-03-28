{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nyra.desktops.hyprland.hyprexpo;
in
{
  config = lib.mkIf (cfg.enable) {
    wayland.windowManager.hyprland.plugins = with pkgs.hyprlandPlugins; [
      hyprexpo
    ];

    wayland.windowManager.hyprland.extraConfig = ''
      plugin:hyprexpo {
        columns = 3
        gap_size = 5
        bg_col = rgb(111111)
        # [center/first] [workspace] e.g. first 1 or center m+1
        workspace_method = center current
        gesture_distance = 300 # how far is the "max" for the gesture
      }
    '';
  };
}
