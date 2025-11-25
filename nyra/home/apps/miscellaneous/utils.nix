{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.home.apps.miscellaneous;
in
{
  options.nyra.home.apps.miscellaneous = {
    enableUtils = mkEnableOption "utils";
  };

  config = mkIf cfg.enableUtils {
    home.packages = with pkgs; [
      clolcat
      hyprpicker
      fontfor
      geticons
      figlet
      dtrx
      vlc
    ]; 
  };
}
