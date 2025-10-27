{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.home.apps.browsers;
in
{
  options.nyra.home.apps.browsers = {
    firefox = {
      enable = mkEnableOption "firefox";
    };
    librewolf = {
      enable = mkEnableOption "librewolf";
    };
  };

  config = {
    home.packages = optionals cfg.firefox.enable [pkgs.firefox];

    programs.librewolf = {
      enable = cfg.librewolf.enable;
      # TODO: add librewolf config
    };
  };
}
