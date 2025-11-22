{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.home.apps.editors.gimp;
in
{
  options.nyra.home.apps.editors.gimp = {
    enable = mkEnableOption "gimp";
  };

  config = {
    home.packages = with pkgs; optionals (cfg.enable) [ gimp-with-plugins ];
  };
}
