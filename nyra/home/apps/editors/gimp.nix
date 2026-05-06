{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nyra.apps.editors.gimp;
in
{
  options.nyra.apps.editors.gimp = {
    enable = lib.mkEnableOption "gimp";
  };

  config = {
    home.packages = lib.optionals (cfg.enable) [ pkgs.gimp-with-plugins ];
  };
}
