{ config, lib, inputs, pkgs, ... }:

{
  imports = [
    inputs.eden.homeModules.default
  ];

  options.nyra.home.apps.eden = {
    enable = lib.mkEnableOption "eden";
  };

  config = {
    home.packages = lib.optionals config.nyra.home.apps.eden.enable [ pkgs.nsz ];

    programs.eden.enable = config.nyra.home.apps.eden.enable;
  };
}

