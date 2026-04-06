{ pkgs, ... }:

{
  imports = [
    ./common.nix
    ../base/home.nix
  ];

  # Apps
  nyra.home.apps = {
    defaultTerminal = "kitty";
    defaultBrowser = "zen-twilight";
    defaultFileManager = "yazi";

    # Productivity
    nvf.enable = false;
    helix.enable = true;
    intellij.enable = false;
    zed.enable = false;
    gimp.enable = false;
    aseprite.enable = false;

    # Gaming
    minecraft.enable = true;
    lutris.enable = false;
    heroic.enable = true;
    cemu = {
      enable = true;
      ukmm.enable = true;
    };
    eden.enable = true;
    azahar.enable = false;

    # Socials
    telegram.enable = true;
    discord.enable = true;

    # Miscellaneous
    ghostty.enable = true;
    spicetify.enable = true;
    rmpc.enable = true;
    spotiflac.enable = true;
    btop = {
      enable = true;
      gpu-name = "Radeon 780M";
    };
    fastfetch.enable = true;
    ptracer.enable = false;

    # Packages without configuration
    packages = with pkgs; [
      hyprpicker
      croc
      android-tools
      fontfor
      figlet
      cmatrix
      wev
    ];
  };

  # Services
  nyra.home.services = {
    mpd.enable = true;
  };
}
