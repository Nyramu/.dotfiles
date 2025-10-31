{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.system.desktops;
in
{
  options.nyra.system.desktops = {
    hyprland.enable = mkEnableOption "hyprland";
  };

  config = {
    programs.hyprland = {
      enable = cfg.hyprland.enable;
      xwayland.enable = true;
    }; 
  };
}
