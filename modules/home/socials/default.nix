{ pkgs, ... }:

{
  home.packages = with pkgs; [
    telegram-desktop
    # TODO: setup Discord
    betterdiscord-installer
    betterdiscordctl
  ];
}
