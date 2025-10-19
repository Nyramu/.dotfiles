{ pkgs, inputs, lib, config, ... }:

{
  imports = [ inputs.stylix.homeModules.stylix ];

  # Fix for Stylix on Hyprnix
  options.wayland.windowManager.hyprland.settings = {
    decoration = lib.mkOption {default = {};};
    general = lib.mkOption {default = {};};
    group = lib.mkOption {default = {};};
    misc = lib.mkOption {default = {};};
  };

  config.stylix.enable = true;

  config.stylix.polarity = "dark";

  config.stylix.image = pkgs.fetchurl {
    url = "https://r4.wallpaperflare.com/wallpaper/342/168/1015/waneella-pixel-art-city-sunset-hd-wallpaper-b40612242749e2adddac705dda8a0e2a.jpg";
    hash = "sha256-xAz9egVTCnrM2gqU6T3lMVwA3lt2B4abOySq0Pd9/FM=";
  };

  config.stylix.autoEnable = true;

  config.stylix.targets = { hyprland.enable = lib.mkForce false; };

  config.stylix.base16Scheme = ../styles/sunset.yaml;

}
