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

      font = {
        #family = "nerd-fonts.jetbrains-mono";
        #style = "Regular";
      }; 
    };
  };
}
