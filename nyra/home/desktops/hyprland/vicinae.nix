{ config, lib, pkgs, inputs, ... }: with lib;

let
  cfgHyprland = config.nyra.home.desktops.hyprland;
  stylix = config.stylix;
in
{
  imports = [ inputs.vicinae.homeManagerModules.default ];
  services.vicinae = {
    enable = cfgHyprland.enable;
    settings =  {
      faviconService = "twenty";
      popToRootOnClose = false; # TODO: Check what it does
      rootSearch.searchFiles = false; # TODO: Same here
      theme.name = "vicinae-dark"; #TODO: Change it
      useLayerShell = false;
      window = {
        csd = true;
        opacity = stylix.opacity.desktop;
        #rounding = 10;
      };
    };
  };
}
