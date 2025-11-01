{ config, lib, pkgs, inputs, ... }:

let 
   themeName = config.nyra.theme.defaultTheme;
   theme = import ../../../resources/themes/${themeName}.nix { inherit pkgs; };
in
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  config.stylix = {
    enable = config.nyra.theme.enable;
    autoEnable = config.nyra.theme.enable;

    # Type "fc-list : family | sort | uniq" in the terminal to see every font
    base16Scheme = theme.palette;
    fonts = theme.fonts; 
    image = theme.background;
    polarity = theme.polarity;

    opacity = {
      terminal = 0.6;
      applications = 0.7;
      # I can apply it for desktop and popups
    };
  };
}
