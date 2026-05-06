{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nyra.apps.editors.aseprite;
in
{
  options.nyra.apps.editors.aseprite = {
    enable = lib.mkEnableOption "aseprite";
  };

  config = {
    home.packages = lib.mkIf (cfg.enable) [ pkgs.aseprite ];
  };
}
