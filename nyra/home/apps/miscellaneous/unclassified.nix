{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.home.apps.miscellaneous;
in
{
  options.nyra.home.apps.miscellaneous = {
    enableUnclassified = mkEnableOption "unclassified";
  };

  config = mkIf cfg.enableUnclassified {
    home.packages = with pkgs; [
      clolcat
      figlet
      cmatrix
    ];
  };
}
