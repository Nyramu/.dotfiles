{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "None";
        opacity = 0.6;
        blur = false;
      };

      font = {
        #family = "nerd-fonts.jetbrains-mono";
        #style = "Regular";
      };

      colors = {
        primary = {
          background = "#262626";
          foreground = "#ffb0b4";
        };
      
        cursor = {
          text = "#222330";
          cursor = "#ffffff";
        };
        
        selection = {
          text = "#a6dccd";
          background = "#152522";
        };
      
        normal = {
          black = "#000000";
          red = "#ff5555";
          green = "#fa696e";
          yellow = "#e4725f";
          blue = "#bc5453";
          magenta = "#cf1e13";
          cyan = "#e4725f";
          white = "#d3d2a7";
        };
      
        bright = {
          black = "#909090";
          red = "#ff5454";
          green = "#50fa7b";
          yellow = "#f0fa8b";
          blue = "#25669b";
          magenta = "#ff78c5";
          cyan = "#8ae9fc";
          white = "#ffffff";
        };
      }; 
    };
  };
}
