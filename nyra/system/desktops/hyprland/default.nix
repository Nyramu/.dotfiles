{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./hyprlock.nix
  ];
  programs.hyprland = {
    enable = config.nyra.desktops.hyprland.enable;
    package = pkgs.hyprland;
    xwayland.enable = true;
  };
}
