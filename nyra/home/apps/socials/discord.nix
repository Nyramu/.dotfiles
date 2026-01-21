{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.nyra.home.apps = {
    discord.enable = mkEnableOption "discord";
  };

  config = {
    home.packages =
      with pkgs;
      optionals config.nyra.home.apps.discord.enable [
        (pkgs.discord.override {
          withEquicord = true;
          withOpenASAR = false;
        })
      ];
  };
}
