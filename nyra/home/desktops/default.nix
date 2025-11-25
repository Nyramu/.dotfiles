{ pkgs, ... }:

{
  imports = [
    ./hyprland
  ];

  home.packages = with pkgs; [
    wl-clipboard
    wl-clip-persist
  ];
}
