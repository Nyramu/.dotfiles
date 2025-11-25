{ ... }:

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
    };
    browsers = {
      default = "zen-beta";
      #qutebrowser.enable = true;
    };
    gaming = {
      minecraft.enable = true;
      cemu.enable = true;
    };
    socials = {
      telegram.enable = true;
      discord.enable = true;
    };
    media = {
      music.enable = true; # Enables mpd, rmpc, cava
    };
    miscellaneous = {
      enableUtils = true; # See all packages in nyra/home/apps/miscellaneous/utils.nix
      enableUnclassified = true; # See all packages in nyra/home/apps/miscellaneous/unclassified.nix
      btop.enable = true;
      fastfetch.enable = true;
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
