{ config, lib, pkgs, ... }:

let
  themeName = config.nyra.theme.defaultTheme;
  theme = import ../../../../resources/themes/${themeName}.nix { inherit pkgs; }; 
in
{   
  wayland.windowManager.hyprland = {
    # Window rules
    config.windowrulev2 = [
      "noborder, class:(org.qutebrowser.qutebrowser)"
      "noshadow, class:(org.qutebrowser.qutebrowser)"
    ];

    # <https://wiki.hyprland.org/Configuring/Variables/#general>
    config.general = {
      border_size = 3;
      resize_on_border = true;

      gaps_inside = 5;
      gaps_outside = 25;

      active_border_color = "${theme.hypr.active_border_color} 270deg";
      inactive_border_color = theme.hypr.inactive_border_color;

      layout = "dwindle";
      allow_tearing = false;
    };

    config.decoration = {
      rounding = 2;
      shadow = {
        range = 5;
        render_power = 3;
        color = theme.hypr.decoration.shadow.color;
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

    config.gesture = "3, pinch, fullscreen";

    config.misc = {
      disable_hyprland_logo = true;
      force_default_wallpaper = 0;
      animate_mouse_windowdragging = false; # Just lags for some reason
    };

    # Set wallpaper
    config.exec = [ "nice -n -20 swaybg -m fill -i ${config.stylix.image}" ];
    # Start waybar
    config.exec_once = [ 
      "${lib.getExe pkgs.waybar}" 
    ];
  };
    
  home.packages = with pkgs; [ swaybg ];
}   
