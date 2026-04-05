{ pkgs, ... }:

{
  imports = [
    ./hyprland
    ./noctalia
    ./vicinae
  ];

  home.packages = with pkgs; [
    wl-clipboard
    wl-clip-persist
  ];
}
