{ config, lib, pkgs, ... }:

let
  apps = config.nyra.home.apps;
in
{
  wayland.windowManager.hyprland = {
    keyBinds = let
      MOUSE_L = "mouse:272";
      MOUSE_R = "mouse:273";

      terminal = "${apps.terminals.default}";
      browser = "${apps.browsers.default}";
      fileManager = "nautilus"; #TODO: change file manager

      groups = {
        launchApps = {
          binds = {
            "SUPER_L, B" = "exec, ${browser}";
            "SUPER_L, E" = "exec, ${fileManager}";
            "SUPER_L, S" = "exec, steam";
            "SUPER_L, T" = "exec, Telegram";
            "SUPER_R, RETURN" = "exec, ${terminal}";
          };
        };

        windowToggles = {
          bind.", F11" = "fullscreen";
          bind.", Home" = "fullscreen";
          binds = {
            "SUPER_L, P" = "pseudo";
            "SUPER_L, J" = "togglesplit";
            "SUPER_L, V" = "togglefloating";
          };
        };

        mouseWindowControl = {
          bindm = {
            "SUPER_L, ${MOUSE_L}" = "movewindow";
            "SUPER_L, ${MOUSE_R}" = "resizewindow";
          };
        };

        audioControl = {
          binde.", XF86AudioRaiseVolume" = "exec, ${pkgs.pamixer}/bin/pamixer -i 5";
          binde.", XF86AudioLowerVolume" = "exec, ${pkgs.pamixer}/bin/pamixer -d 5";
          bind.", XF86AudioMute" = "exec, ${pkgs.pamixer}/bin/pamixer -t";
        };

        brightnessControl = {
          binde.", XF86MonBrightnessUp" = "exec, ${pkgs.brightnessctl}/bin/brightnessctl set +5%";
          binde.", XF86MonBrightnessDown" = "exec, ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
        };
        
        powerControl = {
          binds."SUPER_R, R" = "exec, systemctl reboot"; 
          binds."SUPER_R, P" = "exec, systemctl poweroff";
        };
  
        sessionControl = {
          binds."SUPER_R, L" = "exit";
        };

        changeFocus = {
          binds = {
            "SUPER_L, Tab" = "cyclenext"; # Change focus to another window
          };
        };

        moveFocus = {
          binds = {
            "SUPER_L, up" = "movefocus, u";
            "SUPER_L, down" = "movefocus, d";
            "SUPER_L, left" = "movefocus, l";
            "SUPER_L, right" = "movefocus, r";
          };
        };

        changeWorkspace = {
          bind = {
            "SUPER_L, 1" = "workspace, 1";
            "SUPER_L, 2" = "workspace, 2";
            "SUPER_L, 3" = "workspace, 3";
            "SUPER_L, 4" = "workspace, 4";
            "SUPER_L, 5" = "workspace, 5";
            "SUPER_L, 6" = "workspace, 6";
            "SUPER_L, 7" = "workspace, 7";
            "SUPER_L, 8" = "workspace, 8";
            "SUPER_L, 9" = "workspace, 9";
            "SUPER_L, 0" = "workspace, 0"; 
          };
        };
  
        moveToWorkspace = {
          bind = {
            "SUPER_L_SHIFT, 1" = "movetoworkspace, 1";
            "SUPER_L_SHIFT, 2" = "movetoworkspace, 2";
            "SUPER_L_SHIFT, 3" = "movetoworkspace, 3";
            "SUPER_L_SHIFT, 4" = "movetoworkspace, 4";
            "SUPER_L_SHIFT, 5" = "movetoworkspace, 5";
            "SUPER_L_SHIFT, 6" = "movetoworkspace, 6";
            "SUPER_L_SHIFT, 7" = "movetoworkspace, 7";
            "SUPER_L_SHIFT, 8" = "movetoworkspace, 8";
            "SUPER_L_SHIFT, 9" = "movetoworkspace, 9"; 
            "SUPER_L_SHIFT, 0" = "movetoworkspace, 0"; 
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
          groups.windowToggles
          groups.changeFocus
          { binds."SUPER_R, K" = "killactive"; } # Kills active window
          groups.moveFocus
          # Workspace control
          groups.changeWorkspace
          groups.moveToWorkspace
          # Launch apps
          groups.launchApps
        ];
  };
}
