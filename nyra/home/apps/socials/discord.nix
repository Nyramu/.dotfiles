{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nyra.apps.socials.discord;
in
{
  options.nyra.apps.socials = {
    discord.enable = lib.mkEnableOption "discord";
  };

  config = lib.mkIf (cfg.enable) {
    home.packages = [
      (pkgs.discord.override {
        withEquicord = true;
        withOpenASAR = false;
      })
    ];
  };
}
