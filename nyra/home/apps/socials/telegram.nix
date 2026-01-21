{
  config,
  lib,
  inputs,
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
        inputs.ayugram.packages.${pkgs.stdenv.hostPlatform.system}.ayugram-desktop
      ];
  };
}
