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
    home.packages =
      lib.optionals cfg.enable [ pkgs.cemu ] ++
      lib.optionals cfg.enable && cfg.ukmm.enable [ pkgs.ukmm ];
  };
}

