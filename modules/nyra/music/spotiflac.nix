{ self, lib, ... }:
{
  flake.modules.homeManager = {
    music.imports = [ self.modules.homeManager.spotiflac ];

    spotiflac =
      { config, host, ... }:

      let
        cfg = config.nyra.music.spotiflac;
      in
      {
        options.nyra.music.spotiflac = {
          enable = lib.mkEnableOption "spotiflac";
        };

        config = lib.mkIf (cfg.enable) {
          home.packages = [
            self.packages.${host.system}.spotiflac
          ];
        };
      };
  };
}
