{ config, inputs, ... }:

let
  cfgHyprland = config.nyra.home.desktops.hyprland;
in
{
  imports = [ inputs.vicinae.homeManagerModules.default ];
  services.vicinae = {
    enable = cfgHyprland.enable;
    settings =  {
      faviconService = "twenty";
      popToRootOnClose = false; # TODO: Check what it does
      rootSearch.searchFiles = false; # TODO: Same here
      useLayerShell = false;
      window = {
        csd = true;
        rounding = 10;
      };
    };
  };
}
