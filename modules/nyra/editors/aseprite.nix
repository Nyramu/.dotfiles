{ self, lib, ... }:
{
  flake.modules.homeManager = {
    editors.imports = [ self.modules.homeManager.aseprite ];

    aseprite =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.editors.aseprite;
      in
      {
        options.nyra.editors.aseprite = {
          enable = lib.mkEnableOption "aseprite";
        };

        config = lib.mkIf (cfg.enable) {
          home.packages = [ pkgs.aseprite ];
        };
      };
  };
}
