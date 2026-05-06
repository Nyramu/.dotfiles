{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nyra.gaming.minecraft;
in
{
  options.nyra.gaming.minecraft = {
    enable = lib.mkEnableOption "minecraft";
  };

  config = {
    home.packages = lib.optionals cfg.enable [
      (pkgs.prismlauncher.override {
        jdks = [ pkgs.jdk25 ];
      })
    ];
  };
}
