{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.hyprnix.homeManagerModules.hyprland
    ./config.nix
    ./binds.nix
    # ./plugins.nix
  ];

  # Fix for Hyprnix
  config.services.hyprpaper.enable = lib.mkForce false;
  options.wayland.windowManager.hyprland.settings = {
    decoration = lib.mkOption {default = {};};
    general = lib.mkOption {default = {};};
    group = lib.mkOption {default = {};};
    misc = lib.mkOption {default = {};};
  };
  
  config.wayland.windowManager.hyprland = {
    enable = config.nyra.desktops.hyprland.enable;
    package = pkgs.hyprland;
    systemd.enable = true;
    xwayland.enable = true;
    reloadConfig = true;
    recommendedEnvironment = true;
    
    config.monitor = [
      "eDP-1, 1920x1200@60, auto, 1"
      ", preferred, auto, 1"
    ];

    config.render.direct_scanout = true;

    config.misc = {
      vfr = false;
      vrr = false;
    };

    config.input = {
        kb_layout = "it";
        numlock_by_default = true;
        follow_mouse = 1;
        mouse_refocus = true;
        resolve_binds_by_sym = true;
        kb_options = "fkeys:basic_13-24"; 
    };

    config.cursor = {
      inactive_timeout = 0;
      warp_on_change_workspace = 0;
      hide_on_touch = false;
    };

    config.binds = {
      workspace_center_on = 1;
    };

    config.ecosystem = {
      no_update_news = true;
      no_donation_nag = true;
    };
  };
}
