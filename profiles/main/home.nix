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
      azahar.enable = false;
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
      fastfetch.enable = true;
      yazi.enable = true;
      packages = with pkgs; [
        hyprpicker
        dtrx
        croc
        carbon-now-cli #TODO: Test
        fontfor
        figlet
        cmatrix
        wev
      ];
    };
  };

  # Desktop Environments and Window Managers
  nyra.home.desktops.hyprland.enable = true;
}
