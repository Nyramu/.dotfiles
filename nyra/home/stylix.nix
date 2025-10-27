{ pkgs, inputs, lib, config, ... }:


let 
  theme = import ../../resources/themes/sunset.nix { inherit pkgs; };
in
{
  imports = [ inputs.stylix.homeModules.stylix ];

  config.stylix = {
    enable = true;
    autoEnable = true;

    # Type "fc-list : family | sort | uniq" in the terminal to show all fonts
    base16Scheme = theme.palette;
    fonts = theme.fonts; 
    image = theme.background;
    polarity = theme.polarity;

    opacity = {
      terminal = 0.6;
      applications = 0.7;
      # I can apply it for desktop and popups
    };

    #icons = {
    #  enable = true;
      # TODO add icons.package and icons.dark
    #};
   
    targets = {
      hyprland.enable = lib.mkForce false;
      kitty.enable = lib.mkForce true;
    };
  };

  # Fix for Hyprnix
  options.wayland.windowManager.hyprland.settings = {
    decoration = lib.mkOption {default = {};};
    general = lib.mkOption {default = {};};
    group = lib.mkOption {default = {};};
    misc = lib.mkOption {default = {};};
  };
}
