{ config, pkgs, ... }:

let 
   theme = import ../../../resources/themes/${config.nyra.theme.defaultTheme}.nix {inherit pkgs;};
in
{
  config.stylix = {
    enable = config.nyra.theme.enable;
    autoEnable = config.nyra.theme.enable;

    base16Scheme = theme.palette;
    fonts = theme.fonts; 
    image = theme.background;
    polarity = theme.polarity;
    opacity = {
      terminal = theme.opacity.terminal or 0.63;
      applications = theme.opacity.applications or 0.6;
      desktop = theme.opacity.desktop or 0.7;
      popups = theme.opacity.popups or 0.7;
    };
    icons = {
      enable = true;
      package = pkgs.gruvbox-plus-icons;
      dark = "gruvbox-plus";
      light = "gruvbox-plus";
    };
  };
}
