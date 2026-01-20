{ config, lib, pkgs, ... }:

{
  options.nyra.home.apps.intellij = {
    enable = lib.mkEnableOption "intellij";
  };

  config = {
    home.packages = lib.optionals (config.nyra.home.apps.intellij.enable) [
      pkgs.jetbrains.idea
      pkgs.openjdk25
    ];
  };
}

