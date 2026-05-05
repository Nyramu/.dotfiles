{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nyra.services.mysql;
in
{
  options.nyra.services.mysql = {
    enable = lib.mkEnableOption "mysql";
  };

  config = lib.mkIf (cfg.enable == true) {
    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
  };
}
