{ lib, pkgs, ... }:

{
  imports = [
    ./hyprland
    ./noctalia.nix
    ./vicinae.nix
  ];

  options.nyra.home.desktops = {
    hyprland.enable = lib.mkEnableOption "hyprland";
  };
  
  config = {
    home.packages = with pkgs; [
      wl-clipboard
      wl-clip-persist
    ];
  };
}
