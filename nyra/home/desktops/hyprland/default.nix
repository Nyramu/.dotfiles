{ config, lib, pkgs, inputs, ... }: with lib;

let
  cfg = config.nyra.home.desktops.hyprland;
in
{
  imports = [
    inputs.hyprnix.homeManagerModules.hyprland
    ./config.nix
    ./binds.nix
  ];

  options.nyra.home.desktops.hyprland = {
    enable = mkEnableOption "hyprland";
  };

  config.wayland.windowManager.hyprland = {
    enable = cfg.enable;
    package = pkgs.hyprland;

    systemd.enable = true;
    xwayland.enable = true;
    reloadConfig = true;
    recommendedEnvironment = true;
    
    config.ecosystem.no_update_news = true;

    config.monitor = [
      "eDP-1, 1920x1200@60, auto, 1"
      ", preferred, auto, 1"
    ];

    config.render.direct_scanout = true;

    config.misc.vfr = false;

    config.input = {
        kb_layout = "it";
        numlock_by_default = true;
        follow_mouse = 1;
        resolve_binds_by_sym = true;
    };
  };
}
