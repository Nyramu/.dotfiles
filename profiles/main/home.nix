{ pkgs, inputs, ... }:

{
  imports = [ ../../nyramu/home-manager/default.nix ];
  

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

  programs.home-manager.enable = true;
}
