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
    stateVersion = "25.11";
    packages = with pkgs; [ screenShot screenRecord ];
  };
  news.display = "silent";

  programs.home-manager.enable = true;
}
