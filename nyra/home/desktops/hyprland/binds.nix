{
  config,
  lib,
  pkgs,
  ...
}:

let
  apps = config.nyra.home.apps;
in
{
  wayland.windowManager.hyprland = {
    keyBinds =
      let
        MOUSE_L = "mouse:272";
        MOUSE_R = "mouse:273";

        terminal = "${lib.getExe pkgs.${apps.defaultTerminal}}";
        browser = "${apps.defaultBrowser}";
        fileManager = "${lib.getExe pkgs.yazi}";
        groups = {
          launchApps = {
            bind = {
              "SUPER, B" = "exec, ${browser}";
              "SUPER, E" = "exec, ${terminal} -e ${fileManager}";
              "SUPER, S" = "exec, steam %U";
              "SUPER, T" = "exec, AyuGram"; # Telegram
              "SUPER, H" = "exec, ${terminal} -e btop";
              "SUPER, M" = "exec, ${terminal} --title rmpc -e -o background_opacity=0.9 rmpc"; # RMPC but in a cool window
              "SUPER, SPACE" = "exec, vicinae toggle";

              # Terminal keybinds
              "SUPER, RETURN" = "exec, ${terminal}";
              "SUPER_ALT, RETURN" = "exec, ${terminal} --title fastfetch --hold fastfetch"; # Fastfetch but in a cool window

              "SUPER, BACKSPACE" = "exec, ${terminal} -e hx"; # Helix
            };
          };

          restartApps = {
            # Noctalia
            bind."SUPER_SHIFT, W" = "exec, systemctl --user restart noctalia-shell.service";

            # Vicinae
            bind."SUPER_SHIFT, SPACE" = "exec, vicinae server --replace";
          };

          screenCapture = {
            # Press to start recording, then press again to stop and save
            bind.", F9" = "exec, screen-record"; # Max quality, 60 fps
            bind."SUPER, F9" = "exec, screen-record --low-quality"; # Lower bitrate, 30 fps
            # Copy screenshot to clipboard without saving
            bind.", F10" = "exec, screen-shot";
            bind.", Print" = "exec, screen-shot";
            # Copy screenshot to clipboard and save
            bind."SUPER, F10" = "exec, screen-shot --save";
            bind."SUPER, Print" = "exec, screen-shot --save";
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

            # Move focus
            bind = {
              "SUPER, up" = "movefocus, u";
              "SUPER, down" = "movefocus, d";
              "SUPER, left" = "movefocus, l";
              "SUPER, right" = "movefocus, r";
            };
          };

          mouseWindowControl = {
            bindm = {
              "SUPER, ${MOUSE_L}" = "movewindow";
              "SUPER, ${MOUSE_R}" = "resizewindow";
            };
          };

          groupControl = {
            bind = {
              "SUPER, G" = "togglegroup"; # Create/destroy a group
              "SUPER_SHIFT, G" = "lockactivegroup, toggle"; # Lock/unlock active group

              # Acts as moveintogroup/moveoutofgroup/movewindow
              "SUPER_SHIFT, up" = "movewindoworgroup, u";
              "SUPER_SHIFT, down" = "movewindoworgroup, d";
              "SUPER_SHIFT, left" = "movewindoworgroup, l";
              "SUPER_SHIFT, right" = "movewindoworgroup, r";

              "SUPER, Tab" = "changegroupactive, f"; # Move forward
              "SUPER_SHIFT, Tab" = "changegroupactive, b"; # Move back
            };
          };

          audioControl = {
            binde.", XF86AudioRaiseVolume" = "exec, ${lib.getExe pkgs.pamixer} -i 5";
            binde.", XF86AudioLowerVolume" = "exec, ${lib.getExe pkgs.pamixer} -d 5";
            bind.", XF86AudioMute" = "exec, ${lib.getExe pkgs.pamixer} -t";
          };

          brightnessControl = {
            binde.", XF86MonBrightnessUp" = "exec, ${lib.getExe pkgs.brightnessctl} set +5%";
            binde.", XF86MonBrightnessDown" = "exec, ${lib.getExe pkgs.brightnessctl} set 5%-";
          };

          sessionControl = {
            bind."SUPER_SHIFT, R" = "exec, systemctl reboot";
            bind."SUPER_SHIFT, P" = "exec, systemctl poweroff";
            bind."SUPER_SHIFT, L" = "exit";
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
        groups.audioControl
        groups.brightnessControl
        groups.sessionControl
        # Window control
        groups.mouseWindowControl
        groups.windowControl
        groups.groupControl
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
