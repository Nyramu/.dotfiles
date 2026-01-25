{
  config,
  lib,
  pkgs,
  ...
}:
  
{
  options.nyra.home.apps.aseprite = {
    enable = lib.mkEnableOption "aseprite";
  };

  config = {
    home.packages = lib.mkIf (config.nyra.home.apps.aseprite.enable) [ pkgs.aseprite ];
  };
}
