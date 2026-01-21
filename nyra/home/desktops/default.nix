{ pkgs, ... }:

{
  imports = [
    ./hyprland
    ./noctalia.nix
    ./vicinae.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard
    wl-clip-persist
  ];
}
