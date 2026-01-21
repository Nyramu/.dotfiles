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
    };
    browsers.default = "zen-beta";
    media = {
      vlc.enable = true;
    };
    miscellaneous = {
      btop = {
        enable = true;
        gpu-name = "Radeon R8M445DX";
      };
      yazi.enable = true;
      fastfetch.enable = true;
      packages = with pkgs; [
        hyprpicker
        dtrx
        croc
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
