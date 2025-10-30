{ config, lib, pkgs, ... }: with lib;


let
  cfg = config.nyra.home.apps.socials;
in
{
  options.nyra.home.apps.socials = {
    telegram.enable = mkEnableOption "telegram";
    discord.enable = mkEnableOption "discord";
  };

  config = {
    home.packages = with pkgs;
      optionals cfg.telegram.enable [ telegram-desktop ] ++
      optionals cfg.discord.enable [ (discord.override {withVencord = true;}) betterdiscord-installer ];
  };
}
