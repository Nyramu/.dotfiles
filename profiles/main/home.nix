{ pkgs, ... }:

{
  imports = [
    ./common.nix
    ../base/home.nix
  ];

  # Apps
  nyra.apps = {
    terminals = {
      default = "kitty";
      ghostty.enable = true;
    };
    browsers.default = "zen-twilight";
    files.default = "yazi";

    editors = {
      nvf.enable = false;
      helix.enable = true;
      intellij.enable = false;
      zed.enable = false;
      gimp.enable = false;
      aseprite.enable = false;
    };

    socials = {
      telegram.enable = true;
      discord.enable = false;
    };

    misc = {
      spicetify.enable = true;
      rmpc.enable = true;
      spotiflac.enable = true;
      btop = {
        enable = true;
        gpu-name = "Radeon 780M";
      };
      fastfetch.enable = true;
      ptracer.enable = false;
    };

    # Packages without configuration
    packages = with pkgs; [
      qbittorrent
      hyprpicker
      croc
      android-tools
      fontfor
      figlet
      cmatrix
      oxipng # pngquant is the best to drop below 1 MB
      wev
    ];
  };

  nyra.gaming = {
    minecraft.enable = true;
    lutris.enable = false;
    # heroic.enable = true; # Temporarily broken
    cemu = {
      enable = true;
      ukmm.enable = true;
    };
    eden.enable = true;
    azahar.enable = false;
  };

  nyra.services = {
    mpd.enable = true;
  };
}
