{ self, lib, ... }:
{
  flake.modules.homeManager = {
    productivity.imports = [ self.modules.homeManager.aseprite ];

    aseprite =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.productivity.aseprite;
      in
      {
        options.nyra.productivity.aseprite = {
          enable = lib.mkEnableOption "aseprite";
        };

        config = lib.mkIf (cfg.enable) {
          home.packages = [ pkgs.aseprite ];
        };
      };
  };
}
