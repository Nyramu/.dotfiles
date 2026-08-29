{ lib, ... }:
{
  flake.modules.homeManager.browsers =
    { config, nyralib, ... }:
    
    let
      browser = config.nyra.browsers.default;
    in
    {
      options.nyra.browsers.default = nyralib.mkDefaultOption "browser" ./.;
      
      config = {
        hyprnix.settings.bind = lib.mkIf (config.nyra.desktops.hyprland.enable) {
          "SUPER + B".dispatcher.exec_cmd = browser;
        };
      };
    };
}
