{
  config,
  lib,
  pkgs,
  ...
}:
  
let
  cfg = config.nyra.home.apps.zed;
in
{
  options.nyra.home.apps.zed = {
    enable = lib.mkEnableOption "zed";
  };

  config = {
    programs.zed-editor = {
      enable = cfg.enable;
      extensions = [];
    };
  };
}
