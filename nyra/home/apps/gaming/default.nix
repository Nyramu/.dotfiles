{ config, lib, inputs, pkgs, ... }: with lib;

let
  cfg = config.nyra.home.apps.gaming;
in
{
  imports = [
    inputs.eden.homeModules.default
  ];

  options.nyra.home.apps.gaming = {
    minecraft.enable = mkEnableOption "minecraft";
    cemu.enable = mkEnableOption "cemu";
    eden.enable = mkEnableOption "Eden Emulator";
  };

  config = {
    home.packages = with pkgs; 
      optionals cfg.minecraft.enable [ prismlauncher ] ++
      optionals cfg.cemu.enable [ cemu ] ++
      optionals cfg.eden.enable [ nsz ];

    programs.eden.enable = cfg.eden.enable;
  };
}
