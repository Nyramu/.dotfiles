{ lib, ... }:

{
  options.nyra.desktops = {
    hyprland.enable = lib.mkEnableOption "hyprland";
  };
}
