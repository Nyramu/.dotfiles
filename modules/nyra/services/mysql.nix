{ self, lib, ... }:
{
  flake.modules.nixos = {
    services.imports = [ self.modules.nixos.mysql ];

    mysql =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.services.mysql;
      in
      {
        options.nyra.services.mysql = {
          enable = lib.mkEnableOption "mysql";
        };

        config = lib.mkIf (cfg.enable) {
          services.mysql = {
            enable = true;
            package = pkgs.mariadb;
          };
        };
      };
  };
}
