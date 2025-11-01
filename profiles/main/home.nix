{ pkgs, inputs, ... }:

{
  imports = [
    ../base/home.nix
  ];
 
  # Theming
  nyra.theme = {
    enable = true;
    defaultTheme = "sunset";
  };

  # Apps
  nyra.home.apps = {
    terminals = {
      kitty.enable = true;
      alacritty.enable = true;
    };
    editors = {
      nvf.enable = true;
    };
    browsers = {
      firefox.enable = true;
      librewolf.enable = true;
    };
    socials = {
      telegram.enable = true;
      discord.enable = true;
    };
    miscellaneous = {
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
}
