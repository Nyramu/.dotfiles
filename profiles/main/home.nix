{ pkgs, ... }:

{
  imports = [
    ../base/home.nix
    ./common.nix
  ];

  # Apps
  nyra.home.apps = {
    terminals = {
      default = "kitty";
      alacritty.enable = true;
    };
    editors = {
      nvf.enable = true;
      gimp.enable = true;
      aseprite.enable = true;
    };
    browsers = {
      default = "zen-beta";
      #qutebrowser.enable = true;
    };
    gaming = {
      minecraft.enable = true;
      cemu.enable = true;
      eden.enable = true;
    };
    socials = {
      telegram.enable = true;
      #discord.enable = true;
    };
    media = {
      music.enable = true; # Enables mpd, rmpc, cava
      vlc.enable = true;
    };
    miscellaneous = {
      btop = {
        enable = true;
        gpu-name = "Radeon 780M"; 
      };
      yazi.enable = true; 
      fastfetch.enable = true;
      packages = with pkgs; [
        hyprpicker
        dtrx
        croc
        fontfor
        clolcat
        figlet
        cmatrix
        wev
      ];
    };
  };

  # Shells and commands
  nyra.home.shells = {
    zsh.enable = true;
    commands = {
      pay-respects.enable = true;
    };
  };

  nyra.home.desktops.hyprland.enable = true;
}
