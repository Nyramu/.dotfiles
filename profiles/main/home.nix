{ pkgs, ... }:

{
  imports = [
    ../base/home.nix
    ./common.nix
  ];

  # Apps
  nyra.home.apps = {
    terminals.default = "kitty";
    editors = {
      nvf.enable = false;
      helix.enable = true;
      intellij.enable = true;
      gimp.enable = true;
      aseprite.enable = false;
    };
    browsers.default = "zen-beta";
    gaming = {
      minecraft.enable = true;
      cemu.enable = true;
      eden.enable = true;
      azahar.enable = false;
    };
    socials = {
      telegram.enable = true;
      discord.enable = true;
    };
    rmpc.enable = true;
    miscellaneous = {
      btop = {
        enable = true;
        gpu-name = "Radeon 780M"; 
      }; 
      fastfetch.enable = true;
      yazi.enable = true;
      ptracer.enable = false;
      packages = with pkgs; [
        hyprpicker
        croc
        carbon-now-cli #TODO: Test
        fontfor
        figlet
        cmatrix
        wev
      ];
    };
  };

  # Services
  nyra.home.services = {
    mpd.enable = true;
  };
  
  # Desktop Environments and Window Managers
  nyra.home.desktops.hyprland.enable = true;
}
