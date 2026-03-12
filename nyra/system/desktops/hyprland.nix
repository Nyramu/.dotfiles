{
  config,
  inputs,
  pkgs,
  ...
}:

{
  programs.hyprland = {
    enable = config.nyra.desktops.hyprland.enable;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    xwayland.enable = true;
  };
}
