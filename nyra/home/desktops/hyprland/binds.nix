{ config, lib, pkgs, ... }: with lib;

let
  apps = config.nyra.home.apps;
in
{
  wayland.windowManager.hyprland = {
    keyBinds = let
      MOUSE_L = "mouse:272";
      MOUSE_R = "mouse:273";

      terminal = "${getExe pkgs.${apps.terminals.default}}";
      browser = "${getExe pkgs.${apps.browsers.default}}";
      fileManager = "nautilus"; #TODO: change file manager

      groups = {
        launchApps = {
          bind = {
            "SUPER, B" = "exec, ${browser}";
            "SUPER, E" = "exec, ${fileManager}";
            "SUPER, S" = "exec, ${getExe pkgs.steam}";
            "SUPER, T" = "exec, ${getExe pkgs.telegram-desktop}";
            "SUPER, H" = "exec, ${terminal} -e ${getExe pkgs.btop}"; 
            "SUPER, RETURN" = "exec, ${terminal}";
          };
        };

        waybar = {
          bind."SUPER_SHIFT, W" = "exec, pkill ${pkgs.waybar.pname}; ${getExe pkgs.waybar}";
        };

        windowControl = {
          bind."SUPER, K" = "killactive"; # Kills active window
          # Fullscreen toggle
          bind = {
            ", F11" = "fullscreen";
            ", Home" = "fullscreen";
          };
          # Window toggles
          bind = {
            "SUPER, P" = "pseudo";
            "SUPER, J" = "togglesplit";
            "SUPER, V" = "togglefloating";
          };
        };

        mouseWindowControl = {
          bindm = {
            "SUPER, ${MOUSE_L}" = "movewindow";
            "SUPER, ${MOUSE_R}" = "resizewindow";
          };
        };

        audioControl = {
          binde.", XF86AudioRaiseVolume" = "exec, ${getExe pkgs.pamixer} -i 5";
          binde.", XF86AudioLowerVolume" = "exec, ${getExe pkgs.pamixer} -d 5";
          bind.", XF86AudioMute" = "exec, ${getExe pkgs.pamixer} -t";
        };

        brightnessControl = {
          binde.", XF86MonBrightnessUp" = "exec, ${getExe pkgs.brightnessctl} set +5%";
          binde.", XF86MonBrightnessDown" = "exec, ${getExe pkgs.brightnessctl} set 5%-";
        };
        
        powerControl = {
          bind."SUPER_SHIFT, R" = "exec, systemctl reboot"; 
          bind."SUPER_SHIFT, P" = "exec, systemctl poweroff";
        };
  
        sessionControl = {
          bind."SUPER_SHIFT, L" = "exit";
        };

        changeFocus = {
          bind = {
            "SUPER, Tab" = "cyclenext"; # Change focus to another window
          };
        };

        moveFocus = {
          bind = {
            "SUPER_SHIFT, up" = "movefocus, u";
            "SUPER_SHIFT, down" = "movefocus, d";
            "SUPER_SHIFT, left" = "movefocus, l";
            "SUPER_SHIFT, right" = "movefocus, r";
          };
        };

        changeWorkspace = {
          bind = {
            "SUPER, 1" = "workspace, 1";
            "SUPER, 2" = "workspace, 2";
            "SUPER, 3" = "workspace, 3";
            "SUPER, 4" = "workspace, 4";
            "SUPER, 5" = "workspace, 5";
            "SUPER, 6" = "workspace, 6";
            "SUPER, 7" = "workspace, 7";
            "SUPER, 8" = "workspace, 8";
            "SUPER, 9" = "workspace, 9";
            "SUPER, 0" = "workspace, 0"; 
          };
        };
  
        moveToWorkspace = {
          bind = {
            "SUPER_SHIFT, 1" = "movetoworkspace, 1";
            "SUPER_SHIFT, 2" = "movetoworkspace, 2";
            "SUPER_SHIFT, 3" = "movetoworkspace, 3";
            "SUPER_SHIFT, 4" = "movetoworkspace, 4";
            "SUPER_SHIFT, 5" = "movetoworkspace, 5";
            "SUPER_SHIFT, 6" = "movetoworkspace, 6";
            "SUPER_SHIFT, 7" = "movetoworkspace, 7";
            "SUPER_SHIFT, 8" = "movetoworkspace, 8";
            "SUPER_SHIFT, 9" = "movetoworkspace, 9"; 
            "SUPER_SHIFT, 0" = "movetoworkspace, 0"; 
          };
        };
      };
      in
        lib.mkMerge [
          # System control
          groups.powerControl
          groups.audioControl
          groups.brightnessControl
          groups.sessionControl
          # Window control
          groups.mouseWindowControl
          groups.windowControl
          groups.changeFocus
          groups.moveFocus
          # Workspace control
          groups.changeWorkspace
          groups.moveToWorkspace
          # Launch apps
          groups.launchApps
          groups.waybar
        ];
  };
}
