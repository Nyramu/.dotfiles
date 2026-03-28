{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nyra.desktops.hyprland.xtra-dispatchers;
in
{
  config = lib.mkIf (cfg.enable) {
    wayland.windowManager.hyprland.plugins = with pkgs.hyprlandPlugins; [
      xtra-dispatchers
    ];
  };
}
