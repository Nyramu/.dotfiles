{ self, lib, ... }:
{
  flake.modules.homeManager = {
    socials.imports = [ self.modules.homeManager.discord ];

    discord =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.socials.discord;
      in
      {
        options.nyra.socials.discord = {
          enable = lib.mkEnableOption "discord";
        };

        config = lib.mkIf (cfg.enable) {
          home.packages = [
            (pkgs.discord.override {
              withEquicord = true;
              withOpenASAR = false;
            })
          ];
        };
      };
  };
}
