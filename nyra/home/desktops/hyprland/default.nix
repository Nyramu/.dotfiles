{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  theme = import ../../../../resources/themes/${config.nyra.theme.name}.nix { inherit pkgs; };
  cfg = config.nyra.desktops.hyprland;
in
{
  imports = [
    inputs.hyprnix.homeManagerModules.hyprland
    ./binds.nix
    ./groups.nix
    ./animations.nix
    ./windowrules.nix
    # ./plugins.nix
  ];

  # Fix for Hyprnix
  config.services.hyprpaper.enable = lib.mkForce false;
  options.wayland.windowManager.hyprland.settings = {
    decoration = lib.mkOption { default = { }; };
    general = lib.mkOption { default = { }; };
    group = lib.mkOption { default = { }; };
    misc = lib.mkOption { default = { }; };
  };

  config.wayland.windowManager.hyprland = {
    enable = cfg.enable;
    package = pkgs.hyprland;
    systemd.enable = true;
    xwayland.enable = true;
    reloadConfig = true;
    recommendedEnvironment = true;
    config = {
      monitor = cfg.monitors or [ ", preferred, auto, 1" ];

      render.direct_scanout = true;

      misc = {
        vfr = false;
        vrr = false;
      };

      input = {
        kb_layout = "it";
        numlock_by_default = true;
        follow_mouse = 1;
        mouse_refocus = true;
        resolve_binds_by_sym = true;
        kb_options = "fkeys:basic_13-24";
      };

      cursor = {
        inactive_timeout = 0;
        warp_on_change_workspace = 0;
        hide_on_touch = false;
      };

      binds = {
        workspace_center_on = 1;
      };

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };
      workspace = [
        "1, persistent:true"
        "2, persistent:true"
        "3, persistent:true"
        "4, persistent:true"
        "5, persistent:true"
      ];

      general = {
        border_size = 2;
        resize_on_border = true;

        gaps_in = 5;
        gaps_out = 4;

        active_border_color = theme.hypr.active_border_color;
        inactive_border_color = theme.hypr.inactive_border_color;

        layout = "dwindle";
        allow_tearing = false;
      };

      decoration = {
        rounding = 8;
        shadow = {
          range = 5;
          render_power = 3;
          color = "rgba(26, 26, 26, 0.93)";
        };
        blur.enabled = false;
      };

      # Gives more freedom in windows management compared to Master
      dwindle = {
        pseudotile = "yes";
        preserve_split = true;
      };

      master.new_status = "master";

      gesture = "3, pinch, fullscreen";

      misc = {
        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
        animate_mouse_windowdragging = false; # Just lags for some reason
      };

      # Set wallpaper
      exec = [ "nice -n -20 ${lib.getExe pkgs.swaybg} -m fill -i ${config.stylix.image}" ];

      env = [
        "HYPRCURSOR_THEME,rose-pine-hyprcursor"
        "HYPRCURSOR_SIZE,36"
      ];
    };
  };
  config.home.packages = with pkgs; [ rose-pine-hyprcursor ];
}
