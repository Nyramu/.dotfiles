{ self, lib, ... }:
{
  flake.modules.homeManager = {
    gaming.imports = [ self.modules.homeManager.azahar ];

    azahar =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.gaming.azahar;
      in
      {
        options.nyra.gaming.azahar = {
          enable = lib.mkEnableOption "azahar";
        };

        config = lib.mkIf (cfg.enable) {
          home.packages = [ pkgs.azahar ];
        };
      };
  };
}
