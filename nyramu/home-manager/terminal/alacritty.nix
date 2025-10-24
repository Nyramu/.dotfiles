{ pkgs, lib, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = lib.mkForce {
        decorations = "None";
        opacity = 0.6;
        blur = false;
      };
      
    };
  }; 
}
