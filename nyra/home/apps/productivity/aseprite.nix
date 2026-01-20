{ config, lib, pkgs, ... }:
{
  options.nyra.home.apps.aseprite = {
    enable = lib.mkEnableOption "aseprite";
  };

  config = {
    home.packages = with pkgs;
      optionals (config.nyra.home.apps.aseprite.enable) [ aseprite ];
  };
}

