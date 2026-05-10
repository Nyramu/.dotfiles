{ self, lib, ... }:
{
  flake.modules.homeManager = {
    socials.imports = [ self.modules.homeManager.telegram ];

    telegram =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.socials.telegram;
      in
      {
        options.nyra.socials.telegram = {
          enable = lib.mkEnableOption "telegram";
        };

        config = lib.mkIf (cfg.enable) {
          home.packages = with pkgs; [
            telegram-desktop
          ];
        };
      };
  };
}
