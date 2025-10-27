{ pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "auto";
        source = ../../../../resources/burrito-ascii.png;
      };
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"

        "separator"
        "cpu"
        "gpu"
        { "type" = "memory"; "key" = "RAM"; }
        "disk"

        "separator"
        "terminal"
        "shell"
        "de"
        "wm"

        "separator"
        { "type" = "display"; "key" = "Display"; }
        { "type" = "battery"; "key" = "Battery"; } 
        "uptime"

        #"separator"
        #"wmtheme"
        #"theme"
        #"icons"
        #"cursor"
        #"break"
        #"colors"
        
        #"packages"
        #"font"
        #"terminalfont"
        #"swap"
        #"poweradapter"
        #"localip"
        #"locale"
      ];
    };
  };
}
