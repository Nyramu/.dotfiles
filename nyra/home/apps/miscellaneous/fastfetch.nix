{ config, lib, ... }: with lib;

let 
  cfg = config.nyra.home.apps.miscellaneous.fastfetch;
in 
{
  options.nyra.home.apps.miscellaneous.fastfetch = {
    enable = mkEnableOption "fastfetch";
    logo = mkOption {
      type = types.enum [ "burrito-ascii" ];
      default = "burrito-ascii";
    };
  };
  
  config = {
    programs.fastfetch = {
      enable = cfg.enable;
      settings = {
        logo = {
          type = "auto";
          source = ../../../../resources/${cfg.logo}.png;
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
  };
}
