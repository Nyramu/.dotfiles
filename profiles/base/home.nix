{ pkgs, userSettings, ... }:

let
  screenShot = pkgs.callPackage ../../nyra/commands/screen-shot {};
  screenRecord = pkgs.callPackage ../../nyra/commands/screen-record {};
in
{
  imports = [
    ../../nyra/home
    ../../nyra/commands/nyra
  ]; 

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_ : true);
  };

  home = {
    username = userSettings.username;
    homeDirectory = "/home/${userSettings.username}";
    stateVersion = "26.05";
    packages = [ screenShot screenRecord ];
  };
  news.display = "silent";

  programs.home-manager.enable = true;

  # Use zsh by default
  nyra.home.shells.zsh.enable = true;
}
