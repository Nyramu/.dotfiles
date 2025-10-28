{ pkgs, inputs, ... }:

{
  imports = [
    ../base/home.nix
    ../../nyra/home
  ];

  nyra.home.apps = {
    browsers = {
      firefox.enable = true;
      librewolf.enable = true;
    };
    socials = {
      telegram.enable = true;
      discord.enable = true;
    };
  };

  nyra.home.shells = {
    zsh.enable = true;
    commands = {
      pay-respects.enable = true;
    };
  };
}
