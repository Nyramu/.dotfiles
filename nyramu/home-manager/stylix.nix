{ pkgs, inputs, lib, config, ... }:


let 
  theme = import ../aesthetics/themes/sunset.nix { inherit pkgs; };
in
{
  imports = [ inputs.stylix.homeModules.stylix ];

  config.stylix = {
    enable = true;
    autoEnable = true;

    # Type "fc-list : family | sort | uniq" in the terminal to see every font
    base16Scheme = theme.palette;
    fonts = theme.fonts; 
    image = theme.background;
    polarity = theme.polarity;
   
    targets = {
      hyprland.enable = lib.mkForce false;
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
