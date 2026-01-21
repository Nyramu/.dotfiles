{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.nyra.home.apps.gimp = {
    enable = lib.mkEnableOption "gimp";
  };

  config = {
    home.packages = lib.optionals (config.nyra.home.apps.gimp.enable) [ pkgs.gimp-with-plugins ];
  };
}
