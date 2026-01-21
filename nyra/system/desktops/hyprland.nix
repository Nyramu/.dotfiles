{ config, ... }:

{
  programs.hyprland = {
    enable = config.nyra.desktops.hyprland.enable;
    xwayland.enable = true;
  };
}
