{ pkgs, inputs, ... }:

{
  imports = [
    ../base/home.nix
    ../../nyra/home
  ];

  nyra.home.apps.browsers = {
    firefox.enable = true;
    librewolf.enable = true;
  };
}
