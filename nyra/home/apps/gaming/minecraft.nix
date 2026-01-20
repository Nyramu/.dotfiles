{ config, lib, pkgs, ... }:

{
  options.nyra.home.apps.minecraft = {
    enable = lib.mkEnableOption "minecraft";
  };

  config = {
    home.packages =
      lib.optionals config.nyra.home.apps.minecraft.enable [ pkgs.prismlauncher ];
  };
}

