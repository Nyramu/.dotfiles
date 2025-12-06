{ pkgs, ... }:

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
    username = "nyramu";
    homeDirectory = "/home/nyramu";
    stateVersion = "26.05";
    packages = [ screenShot screenRecord ];
  };
  news.display = "silent";

  programs.home-manager.enable = true;
}
