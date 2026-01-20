{ config, lib, pkgs, ... }: with lib;

{
  options.nyra.home.apps.gimp = {
    enable = mkEnableOption "gimp";
  };

  config = {
    home.packages = with pkgs;
      optionals (config.nyra.home.apps.gimp.enable) [ gimp-with-plugins ];
  };
}

