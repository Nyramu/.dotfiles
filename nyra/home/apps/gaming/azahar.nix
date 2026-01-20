{ config, lib, pkgs, ... }:

{
  options.nyra.home.apps.azahar = {
    enable = lib.mkEnableOption "azahar";
  };

  config = {
    home.packages = with pkgs; 
      optionals config.nyra.home.apps.azahar.enable [ azahar ];
  };
}

