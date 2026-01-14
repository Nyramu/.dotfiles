{ config, lib, pkgs, ... }:

let
  themeName = config.nyra.theme.defaultTheme;
  theme = import ../../../../resources/themes/${themeName}.nix { inherit pkgs; }; 
in
{   
  wayland.windowManager.hyprland = {
    config = {
      # Window rules
      windowrule = [
        "match:class ^(org.qutebrowser.qutebrowser)$, decorate off"
        
        # Custom titles for kitty
        "match:initial_title ^(rmpc)$, float on"
        "match:initial_title ^(rmpc)$, size 942 558"
        "match:initial_title ^(rmpc)$, center on"
        
        "match:initial_title ^(fastfetch)$, float on"
        "match:initial_title ^(fastfetch)$, size 1100 736"
        "match:initial_title ^(fastfetch)$, center on"
      ];

      workspace = [
        "1, persistent:true"
        "2, persistent:true"
        "3, persistent:true"
        "4, persistent:true"
        "5, persistent:true"  
      ];

      env = [
        "HYPRCURSOR_THEME,rose-pine-hyprcursor"
        "HYPRCURSOR_SIZE,36"
      ];

      # <https://wiki.hyprland.org/Configuring/Variables/#general>
      general = {
        border_size = 2;
        resize_on_border = true;

        gaps_in = 5;
        gaps_out = 4;

        active_border_color = theme.hypr.active_border_color;
        inactive_border_color = theme.hypr.inactive_border_color;

        layout = "dwindle";
        allow_tearing = false;
      };

      decoration = {
        rounding = 8;
        shadow = {
          range = 5;
          render_power = 3;
          color = "rgba(26, 26, 26, 0.93)";
        };
        blur.enabled = false;
      };

      group = {
        auto_group = true;
        insert_after_current = true;
        focus_removed_window = true;
        drag_into_group = 2; # Only on group bar
        merge_groups_on_drag = false;
        # group_on_movetoworkspace = true; # Must test

        active_border_color = theme.hypr.active_border_color;
        inactive_border_color = theme.hypr.inactive_border_color;
        locked_active_border_color = theme.hypr.locked_group_active_border_color;
        locked_inactive_border_color = theme.hypr.inactive_border_color;

        groupbar = {
          font_size = 13;
          gradients = false;
          indicator_height = 1; # Default: 3
          rounding = 8;
          rounding_power = 4.0; # Default: 2.0
          blur = true;
          
          text_color = theme.hypr.text_color;
          text_color_inactive = theme.hypr.inactive_text_color;
          text_color_locked_active = theme.hypr.locked_group_active_text_color;
          text_color_locked_inactive = theme.hypr.inactive_text_color;

          active_color = theme.hypr.active_color;
          inactive_color = theme.hypr.inactive_color;
          locked_active_color = theme.hypr.locked_group_active_color;
          locked_inactive_color = theme.hypr.inactive_color;
        };
      };

      # Gives more freedom in windows management compared to Master
      dwindle = {
        pseudotile = "yes";
        preserve_split = true;
      };

      master.new_status = "master";

      gesture = "3, pinch, fullscreen";

      misc = {
        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
        animate_mouse_windowdragging = false; # Just lags for some reason
      };

      # Set wallpaper
      exec = [ "nice -n -20 swaybg -m fill -i ${config.stylix.image}" ];
      # Start waybar and vicinae
      exec_once = [ 
        "${lib.getExe pkgs.waybar}"
        "noctalia-shell" 
        "vicinae server"
      ];
    };

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
  };
    
  home.packages = with pkgs; [ swaybg rose-pine-hyprcursor ];
}   
