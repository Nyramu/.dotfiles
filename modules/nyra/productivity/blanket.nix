{ self, lib, ... }:
{
  flake.modules.homeManager = {
    productivity.imports = [ self.modules.homeManager.blanket ];

    blanket =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.productivity.blanket;
      in
      {
        options.nyra.productivity.blanket = {
          enable = lib.mkEnableOption "blanket";
        };

        config = lib.mkIf (cfg.enable) {
          home.packages = [
            pkgs.blanket
          ];
        };
      };
  };
}
