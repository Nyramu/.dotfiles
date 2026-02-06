{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nyra.system.mysql;
in
{
  options.nyra.system.mysql = {
    enable = lib.mkEnableOption "mysql";
  };

  config = {
    services.mysql = {
      enable = cfg.enable;
      package = pkgs.mariadb;
    };
  };
}
