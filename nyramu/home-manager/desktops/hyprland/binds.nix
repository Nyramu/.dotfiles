{ pkgs, ... }:

{
  wayland.windowManager.hyprland.settings = {
    bind = [ "SUPER, T, exec, alacritty" "SUPER, L, exit, "];
  };
}
