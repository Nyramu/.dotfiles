{ config, lib, pkgs, ... }:
{
  options.nyra.home.apps = {
    discord.enable = lib.mkEnableOption "discord";
  };

  config = {
    home.packages = with pkgs;
      optionals config.nyra.home.apps.discord.enable [
        (pkgs.discord.override {
          withEquicord = true;
          withOpenASAR = false;
        })
      ]; 
  };
}
