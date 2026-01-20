{ config, lib, pkgs, ... }: with lib;

{
  options.nyra.home.apps.intellij = {
    enable = mkEnableOption "intellij";
  };

  config = {
    home.packages = with pkgs;
      optionals (config.nyra.home.apps.intellij.enable) [
       jetbrains.idea openjdk25
     ];
  };
}

