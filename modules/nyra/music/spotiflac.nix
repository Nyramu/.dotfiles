{ self, lib, ... }:
{
  flake.modules.homeManager = {
    music.imports = [ self.modules.homeManager.spotiflac ];

    spotiflac =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.music.spotiflac;
      in
      {
        options.nyra.music.spotiflac = {
          enable = lib.mkEnableOption "spotiflac";
        };

        config = lib.mkIf (cfg.enable) {
          home.packages = [
            pkgs.spotiflac
          ];
        };
      };
  };
}
