{ pkgs, ... }:

{
  imports = [
    ./common.nix
    ../base/home.nix
  ];

  # Apps
  nyra.home.apps = {
    defaultTerminal = "kitty";
    defaultBrowser = "zen-beta";

    # Productivity
    nvf.enable = false;
    helix.enable = true;
    intellij.enable = true;

    # Socials
    telegram.enable = true;

    # Miscellaneous
    btop = {
      enable = true;
      gpu-name = "Radeon R8 M445DX";
    };
    fastfetch.enable = true;
    yazi.enable = true;
    ptracer.enable = true;

    # Packages without configuration
    packages = with pkgs; [
      hyprpicker
      croc
      fontfor
      wev
    ];
  };
}
