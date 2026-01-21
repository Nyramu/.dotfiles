{ pkgs, ... }:

{
  imports = [
    ../base/home.nix
    ./common.nix
  ];

  # Apps
  nyra.home.apps = {
    defaultTerminal = "kitty";
    defaultBrowser = "zen-beta";

    # Productivity
    nvf.enable = false;
    helix.enable = true;
    intellij.enable = true;
    gimp.enable = true;
    aseprite.enable = false;

    # Gaming
    minecraft.enable = true;
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
    rmpc.enable = true;
    btop = {
      enable = true;
      gpu-name = "Radeon 780M";
    };
    fastfetch.enable = true;
    yazi.enable = true;
    ptracer.enable = false;

    # Packages without configuration
    packages = with pkgs; [
      hyprpicker
      croc
      carbon-now-cli # TODO: Test
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
