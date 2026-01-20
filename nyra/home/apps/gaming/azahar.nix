{ config, lib, pkgs, ... }:

{
  options.nyra.home.apps.azahar = {
    enable = lib.mkEnableOption "azahar";
  };

  config = {
    home.packages = lib.optionals (config.nyra.home.apps.azahar.enable) [
       pkgs.azahar
    ];
  };
}

