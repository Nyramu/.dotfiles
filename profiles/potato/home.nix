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
    helix.enable = true;
    intellij.enable = false;

    # Miscellaneous
    btop = {
      enable = true;
      gpu-name = "Radeon R8 M445DX";
    };
    fastfetch.enable = true;
    ptracer.enable = false;

    # Packages without configuration
    packages = with pkgs; [
      figlet
      hyprpicker
      croc
      fontfor
      wev
    ];
  };
}
