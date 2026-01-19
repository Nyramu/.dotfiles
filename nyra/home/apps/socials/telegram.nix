{ config, lib, inputs, pkgs, ... }:

{
  imports = [];

  options.nyra.home.apps = {
    telegram.enable = lib.mkEnableOption "telegram";
  };

  config = {
    home.packages = with pkgs;
      optionals config.nyra.home.apps.telegram.enable [
        inputs.ayugram-desktop.packages.${pkgs.stdenv.hostPlatform.system}.ayugram-desktop
        telegram-desktop
      ];
  };
}
