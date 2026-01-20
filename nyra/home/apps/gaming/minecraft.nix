{ config, lib, pkgs, ... }:

{
  options.nyra.home.apps.minecraft = {
    enable = lib.mkEnableOption "minecraft";
  };

  config = {
    home.packages = with pkgs; 
      optionals config.nyra.home.apps.minecraft.enable [ prismlauncher ];
  };
}

