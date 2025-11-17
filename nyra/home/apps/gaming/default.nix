{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.home.apps.gaming;
in
{
  options.nyra.home.apps.gaming = {
    minecraft.enable = mkEnableOption "minecraft";
    cemu.enable = mkEnableOption "cemu";
  };

  config = {
    home.packages = 
      optionals cfg.minecraft.enable [ pkgs.prismlauncher ] ++
      optionals cfg.cemu.enable [ pkgs.cemu ];
  };
}
