{ self, lib, ... }:
{
  flake.modules.homeManager = {
    gaming.imports = [ self.modules.homeManager.heroic ];

    heroic =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.gaming.heroic;
      in
      {
        options.nyra.gaming.heroic = {
          enable = lib.mkEnableOption "heroic";
        };

        config = lib.mkIf (cfg.enable) {
          home.packages = [ pkgs.heroic ];
        };
      };
  };
}
