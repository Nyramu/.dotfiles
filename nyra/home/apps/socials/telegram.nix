{
  config,
  lib,
  pkgs,
  ...
}:
with lib;

{
  options.nyra.home.apps = {
    telegram.enable = lib.mkEnableOption "telegram";
  };

  config = {
    home.packages =
      with pkgs;
      optionals config.nyra.home.apps.telegram.enable [
        telegram-desktop
      ];
  };
}
