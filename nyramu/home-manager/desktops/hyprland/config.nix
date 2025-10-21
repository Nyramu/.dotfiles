{ pkgs, config, ... }:

{   
  wayland.windowManager.hyprland = {
    # <https://wiki.hyprland.org/Configuring/Variables/#general>
    config.general = {
      border_size = 3;
      resize_on_border = true;

      gaps_inside = 5;
      gaps_outside = 25;

      active_border_color = "rgb(542624) rgb(d66e65)";
      inactive_border_color = "rgb(152927)";

      layout = "dwindle";
      allow_tearing = false;
    };

    config.decoration = {
      rounding = 2;
      shadow = {
        range = 5;
        render_power = 3;
        color = "rgba(1a1a1aee)";
      };
      blur.enabled = false;
    };

    # Gives more freedom in windows management compared to Master
    config.dwindle = {
      pseudotile = "yes";
      preserve_split = true;
    };

    config.master.new_status = "master";

    animations.animation = {
      # Window creation
      windowsIn = {
        enable = true;
        duration = 200;
        curve = "easeOutCirc";
        style = "gnomed";
      };
      # Window destruction
      windowsOut = {
        enable = true;
        duration = 300;
        curve = "easeOutCirc";
        style = "gnomed";
      };
      # Window movement
      windowsMove = {
        enable = true;
        duration = 300;
        curve = "easeInOutCubic";
        style = "gnomed";
      };

     # Idk what it does, maybe it's associated with windowsIn 
      fadeIn = {
        enable = true;
        duration = 300;
        curve = "easeOutCirc";
      };
      # Idk what it does, maybe it's associated with windowsOut
      fadeOut = {
        enable = true;
        duration = 300;
        curve = "easeOutCirc";
      };

      # Border animation speed
      border = {
        enable = true;
        duration = 100;
      };
      # Border animation fluidity
      borderangle = {
        enable = true;
        duration = 3000;
      };

      # Workspace switch
      workspaces = {
        enable = true;
        duration = 400;
        curve = "easeOutExpo";
        style = "fade";
      }; 
    };

    # Set wallpaper
    config.exec = [ "swaybg -m fill -i ${config.stylix.image}" ];
  };
    
  home.packages = with pkgs; [ swaybg ];
}   
