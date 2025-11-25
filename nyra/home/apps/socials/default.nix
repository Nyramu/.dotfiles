{ config, lib, pkgs, ... }: with lib;


let
  cfg = config.nyra.home.apps.socials;
in
{
  imports = [
    ./discord.nix
  ];

  options.nyra.home.apps.socials = {
    telegram.enable = mkEnableOption "telegram";
  };

  config = {
    home.packages = with pkgs; optionals cfg.telegram.enable [ telegram-desktop ]; 
  };
}
