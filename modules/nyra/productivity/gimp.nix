{ self, lib, ... }:
{
  flake.modules.homeManager = {
    productivity.imports = [ self.modules.homeManager.gimp ];

    gimp =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.productivity.gimp;
      in
      {
        options.nyra.productivity.gimp = {
          enable = lib.mkEnableOption "GIMP";
        };

        config = lib.mkIf (cfg.enable) {
          home.packages = [ pkgs.gimp-with-plugins ];
        };
      };
  };
}
