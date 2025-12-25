{ config, lib, pkgs, ... }: with lib;

let
  apps = config.nyra.home.apps;
  screenShot = pkgs.callPackage ../../../commands/screen-shot {};
  screenRecord = pkgs.callPackage ../../../commands/screen-record {};
in
{
  wayland.windowManager.hyprland = {
    keyBinds = let
      MOUSE_L = "mouse:272";
      MOUSE_R = "mouse:273";

      terminal = "${getExe pkgs.${apps.terminals.default}}";
      browser = "${apps.browsers.default}";
      fileManager = "${getExe pkgs.yazi}";
      groups = {
        launchApps = {
          bind = {
            "SUPER, B" = "exec, ${browser}";
            "SUPER, E" = "exec, ${terminal} -e ${fileManager}";
            "SUPER, S" = "exec, ${getExe pkgs.steam}";
            "SUPER, T" = "exec, ${getExe pkgs.telegram-desktop}";
            "SUPER, D" = "exec, discord";
            "SUPER, I" = "exec, ${getExe pkgs.jetbrains.idea}";
            "SUPER, H" = "exec, ${terminal} -e ${getExe pkgs.btop-rocm}";
            "SUPER, M" = "exec, ${terminal} -e ${getExe pkgs.rmpc}"; # Music player
            "SUPER, SPACE" = "exec, ${getExe pkgs.vicinae} toggle";
            "SUPER, RETURN" = "exec, ${terminal}";

            "SUPER_ALT, RETURN" = "exec, ${terminal} -e hx"; # Helix
          };
        };

        restartApps = {
          # Waybar
          bind."SUPER_SHIFT, W" = "exec, pkill ${pkgs.waybar.pname}; ${getExe pkgs.waybar}";
          # Vicinae
          bind."SUPER_SHIFT, SPACE" = "exec, ${getExe pkgs.vicinae} server --replace";
        };

        screenCapture = {
          # Press to start recording, then press again to stop and save
          bind.", F9" = "exec, ${getExe screenRecord}"; # Max quality, 60 fps
          bind."SUPER, F9" = "exec, ${getExe screenRecord} --low-quality"; # Lower bitrate, 30 fps
          # Copy screenshot to clipboard without saving
          bind.", F10" = "exec, ${getExe screenShot}";
          bind.", Print" = "exec, ${getExe screenShot}";
          # Copy screenshot to clipboard and save
          bind."SUPER, F10" = "exec, ${getExe screenShot} --save";
          bind."SUPER, Print" = "exec, ${getExe screenShot} --save";
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
        mkMerge [
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
          groups.restartApps
          groups.screenCapture
        ];
  };
}
