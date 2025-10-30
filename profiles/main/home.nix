{ pkgs, inputs, ... }:

{
  imports = [
    ../base/home.nix
    ../../nyra/home
  ];

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

  nyra.home.shells = {
    zsh.enable = true;
    commands = {
      pay-respects.enable = true;
    };
  };
}
