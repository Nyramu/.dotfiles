{ config, pkgs, ... }:

let 
   themeName = config.nyra.theme.defaultTheme;
   theme = import ../../resources/themes/${themeName}.nix { inherit pkgs; };
in
{
  config.stylix = {
    enable = config.nyra.theme.enable;
    autoEnable = config.nyra.theme.enable;

    base16Scheme = theme.palette;
    fonts = theme.fonts; 
    image = theme.background;
    polarity = theme.polarity;
    opacity = theme.opacity;

    icons = {
      enable = true;
      package = pkgs.gruvbox-plus-icons;
      dark = "gruvbox-plus";
      light = "gruvbox-plus";
    };
  };
}
