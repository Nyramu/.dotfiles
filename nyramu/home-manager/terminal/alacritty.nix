{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "Transparent";
      };

      font = {
        #family = "nerd-fonts.jetbrains-mono";
        #style = "Regular";
      };

      colors = {
        primary = {
          background = "#262626";
          foreground = "#ffcb83";
        };
      
        cursor = {
          text = "#262626";
          cursor = "#fb521c";
        };
      
        selection = {
          text = "#262626";
          background = "#c03f1f";
        };
      
        normal = {
          black = "#000000";
          red = "#c03900";
          green = "#a3a900";
          yellow = "#caae00";
          blue = "#bd6c00";
          magenta = "#fb5d00";
          cyan = "#f79400";
          white = "#ffc88a";
        };
      
        bright = {
          black = "#6a4e29";
          red = "#ff8b67";
          green = "#f6ff3f";
          yellow = "#ffe36e";
          blue = "#ffbd54";
          magenta = "#fc874f";
          cyan = "#c59752";
          white = "#f9f9fe";
        };
      };
    };
  };
}
