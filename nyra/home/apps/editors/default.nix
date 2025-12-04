{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.home.apps.editors;
in
{
  imports = [
    ./nvf.nix
  ];

  options.nyra.home.apps.editors = {
    gimp.enable = mkEnableOption "gimp";
  };

  config = {
    home.packages = with pkgs;
      optionals (cfg.gimp.enable) [ gimp-with-plugins ];
  };
}
