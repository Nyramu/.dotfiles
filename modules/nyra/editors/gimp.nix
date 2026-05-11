{ self, lib, ... }:
{
  flake.modules.homeManager = {
    editors.imports = [ self.modules.homeManager.gimp ];

    gimp =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.editors.gimp;
      in
      {
        options.nyra.editors.gimp = {
          enable = lib.mkEnableOption "gimp";
        };

        config = lib.mkIf (cfg.enable) {
          home.packages = [ pkgs.gimp-with-plugins ];
        };
      };
  };
}
