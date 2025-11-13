{ pkgs, ... }:

{
  imports = [ ../../nyra/home ]; 

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_ : true);
  };

  home = {
    username = "nyramu";
    homeDirectory = "/home/nyramu";
    stateVersion = "25.11";
    packages = with pkgs; [];
  };
  news.display = "silent";

  programs.home-manager.enable = true;
}
