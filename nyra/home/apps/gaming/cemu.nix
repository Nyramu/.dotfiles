{ config, lib, pkgs, ... }:

let
  cfg = config.nyra.home.apps.cemu;
in
{
  options.nyra.home.apps.cemu = {
    enable = lib.mkEnableOption "cemu";
    ukmm.enable = lib.mkEnableOption "ukmm";
  };

  config = {
    home.packages = with pkgs; 
      optionals cfg.enable [ cemu ] ++
      optionals cfg.enable && cfg.ukmm.enable [ ukmm ];
  };
}

