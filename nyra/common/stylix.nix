{ config, lib, pkgs, inputs, ... }:

let 
   themeName = config.nyra.theme.defaultTheme;
   theme = import ../../resources/themes/${themeName}.nix { inherit pkgs; };
in
{
  config.stylix = {
    enable = config.nyra.theme.enable;
    autoEnable = config.nyra.theme.enable;

    # Type "fc-list : family | sort | uniq" in the terminal to see every font
    base16Scheme = theme.palette;
    fonts = theme.fonts; 
    image = theme.background;
    polarity = theme.polarity;
    opacity = theme.opacity;

    #icons = {
    #  enable = true;
      # TODO add icons.package and icons.dark
    #};
  };
}
