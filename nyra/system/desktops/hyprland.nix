{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.system.desktops.hyprland;
in
{
  options.nyra.system.desktops = {
    hyprland.enable = mkEnableOption "hyprland";
  };

  config = {
    programs.hyprland = {
      enable = cfg.enable;
      xwayland.enable = true;
    }; 
  };
}
