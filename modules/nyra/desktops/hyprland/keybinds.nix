{ self, lib, ... }:
{
  flake.modules.homeManager.hyprland =
    { config, pkgs, ... }:

    let
      inherit (config.nyra) terminals files browsers;
      noctalia = "noctalia-shell ipc call";
      terminal = "${lib.getExe pkgs.${terminals.default}}";
    in
    {
      imports = [
        self.modules.homeManager.terminals
        self.modules.homeManager.files
        self.modules.homeManager.browsers
      ];

      hyprnix.settings.bind = {
        # Launch Apps
        "SUPER + B".dispatcher.exec_cmd = browsers.default;
        "SUPER + S".dispatcher.exec_cmd = "steam %U";
        "SUPER + T".dispatcher.exec_cmd = "Telegram";
        "SUPER + I".dispatcher.exec_cmd = "idea";

        # Launch Terminal Apps
        "SUPER + RETURN".dispatcher.exec_cmd = terminal;
        "SUPER + SHIFT + RETURN".dispatcher.exec_cmd = "${terminal} --class floating-${terminals.default}";
        ## Helix
        "SUPER + BACKSPACE".dispatcher.exec_cmd = "${terminal} -e hx";
        "SUPER + SHIFT + BACKSPACE".dispatcher.exec_cmd = "${terminal} --class floating-${terminals.default} -e hx";
        ## Yazi
        "SUPER + E".dispatcher.exec_cmd = "${terminal} -e ${files.default}";
        "SUPER + SHIFT + E".dispatcher.exec_cmd =
          "${terminal} --class floating-${terminals.default} -e ${files.default}";
        ## Btop
        "SUPER + H".dispatcher.exec_cmd = "${terminal} -e btop";
        ## RMPC but in a cool window
        "SUPER + M".dispatcher.exec_cmd = "${terminal} --title rmpc -e -o background_opacity=0.75 rmpc";

        # Restart Apps
        ## Noctalia
        "SUPER + SHIFT + W".dispatcher.exec_cmd = "pkill .quickshell-wra ; noctalia-shell";
        ## Vicinae service
        "SUPER + SHIFT + SPACE".dispatcher.exec_cmd = "systemctl --user restart vicinae.service";

        # Screen Capture
        ## Press to start recording, then press again to stop and save
        F9.dispatcher.exec_cmd = "screen-record"; # Max quality, 60 fps
        "SUPER + F9".dispatcher.exec_cmd = "screen-record --low-quality"; # Lower bitrate, 30 fps
        ## Copy screenshot to clipboard without saving
        F10.dispatcher.exec_cmd = "screen-shot";
        Print.dispatcher.exec_cmd = "screen-shot";
        ## Copy screenshot to clipboard and save
        "SUPER + F10".dispatcher.exec_cmd = "screen-shot --save";
        "SUPER + Print".dispatcher.exec_cmd = "screen-shot --save";

        # Miscellaneous
        ## Toggle DND on notifications
        "SUPER + SHIFT + D".dispatcher.exec_cmd = "${noctalia} notifications toggleDND";
        ## Toggle X-Ray on floating windows
        "SUPER + X".dispatcher.window.set_prop = {
          prop = "xray";
          value = "toggle";
        };
        ## Toggle window swallowing
        "SUPER + SHIFT + S".dispatcher.window.toggle_swallow = { };

        # Vicinae
        ## Toggle spawn
        "SUPER + SPACE".dispatcher.exec_cmd = "vicinae toggle";
        ## Access clipboard
        "SUPER + C".dispatcher.exec_cmd = "vicinae vicinae://launch/clipboard/history";

        # Audio Control
        XF86AudioRaiseVolume = {
          dispatcher.exec_cmd = "${lib.getExe pkgs.pamixer} -i 5";
          flags.repeating = true;
          flags.locked = true;
        };
        XF86AudioLowerVolume = {
          dispatcher.exec_cmd = "${lib.getExe pkgs.pamixer} -d 5";
          flags.repeating = true;
          flags.locked = true;
        };
        XF86AudioMute = {
          dispatcher.exec_cmd = "${lib.getExe pkgs.pamixer} -t";
          flags.locked = true;
        };

        # Media Control
        ## Play/Pause
        XF86AudioPlay = {
          dispatcher.exec_cmd = "${noctalia} media playPause";
          flags.locked = true;
        };
        ## Previous
        XF86AudioPrev = {
          dispatcher.exec_cmd = "${noctalia} media previous";
          flags.locked = true;
        };
        "SUPER + CTRL + left" = {
          dispatcher.exec_cmd = "${noctalia} media previous";
          flags.locked = true;
        };
        ## Next
        XF86AudioNext = {
          dispatcher.exec_cmd = "${noctalia} media next";
          flags.locked = true;
        };
        "SUPER + CTRL + right" = {
          dispatcher.exec_cmd = "${noctalia} media next";
          flags.locked = true;
        };

        # Brightness Control
        XF86MonBrightnessUp = {
          dispatcher.exec_cmd = "${lib.getExe pkgs.brightnessctl} set +5%";
          flags.repeating = true;
        };
        XF86MonBrightnessDown = {
          dispatcher.exec_cmd = "${lib.getExe pkgs.brightnessctl} set 5%-";
          flags.repeating = true;
        };

        # Session Control
        "SUPER + SHIFT + R".dispatcher.exec_cmd = "systemctl reboot";
        "SUPER + SHIFT + P".dispatcher.exec_cmd = "systemctl poweroff";
        "SUPER + SHIFT + Q".dispatcher.exit = { };
        "SUPER + SHIFT + L".dispatcher.exec_cmd = "${noctalia} lockScreen lock";

        # Mouse Window Control
        "SUPER + mouse:272" = {
          dispatcher.window.drag = { };
          flags.mouse = true;
        };
        "SUPER + mouse:273" = {
          dispatcher.window.resize = { };
          flags.mouse = true;
        };

        # Window Control
        ## Close active window
        "SUPER + K".dispatcher.window.close = { };
        ## Fullscreen toggle
        F11.dispatcher.window.fullscreen.mode = "fullscreen";
        Home.dispatcher.window.fullscreen.mode = "fullscreen";
        ## Floating toggle
        "SUPER + V".dispatcher.window.float.action = "toggle";
        ## Move focus
        "SUPER + up".dispatcher.focus.direction = "up";
        "SUPER + down".dispatcher.focus.direction = "down";
        "SUPER + left".dispatcher.focus.direction = "left";
        "SUPER + right".dispatcher.focus.direction = "right";

        # Group Control
        ## Create/destroy a group
        "SUPER + G".dispatcher.group.toggle = { };
        ## Lock/unlock active group
        "SUPER + SHIFT + G".dispatcher.group.lock_active = { };
        ## Moves window, aware of groups
        "SUPER + SHIFT + up".dispatcher.window.move = {
          direction = "up";
          group_aware = true;
        };
        "SUPER + SHIFT + down".dispatcher.window.move = {
          direction = "down";
          group_aware = true;
        };
        "SUPER + SHIFT + left".dispatcher.window.move = {
          direction = "left";
          group_aware = true;
        };
        "SUPER + SHIFT + right".dispatcher.window.move = {
          direction = "right";
          group_aware = true;
        };

        ## Group tabs
        "SUPER + Tab".dispatcher.group.next = { };
        "SUPER + SHIFT + Tab".dispatcher.group.prev = { };

        # Workspace
        ## Change workspace
        "SUPER + 1".dispatcher.focus.workspace = "1";
        "SUPER + 2".dispatcher.focus.workspace = "2";
        "SUPER + 3".dispatcher.focus.workspace = "3";
        "SUPER + 4".dispatcher.focus.workspace = "4";
        "SUPER + 5".dispatcher.focus.workspace = "5";
        "SUPER + 6".dispatcher.focus.workspace = "6";
        "SUPER + 7".dispatcher.focus.workspace = "7";
        "SUPER + 8".dispatcher.focus.workspace = "8";
        "SUPER + 9".dispatcher.focus.workspace = "9";
        "SUPER + 0".dispatcher.focus.workspace = "0";

        ## Move to workspace
        "SUPER + SHIFT + 1".dispatcher.window.move = {
          workspace = "1";
          follow = true;
        };
        "SUPER + SHIFT + 2".dispatcher.window.move = {
          workspace = "2";
          follow = true;
        };
        "SUPER + SHIFT + 3".dispatcher.window.move = {
          workspace = "3";
          follow = true;
        };
        "SUPER + SHIFT + 4".dispatcher.window.move = {
          workspace = "4";
          follow = true;
        };
        "SUPER + SHIFT + 5".dispatcher.window.move = {
          workspace = "5";
          follow = true;
        };
        "SUPER + SHIFT + 6".dispatcher.window.move = {
          workspace = "6";
          follow = true;
        };
        "SUPER + SHIFT + 7".dispatcher.window.move = {
          workspace = "7";
          follow = true;
        };
        "SUPER + SHIFT + 8".dispatcher.window.move = {
          workspace = "8";
          follow = true;
        };
        "SUPER + SHIFT + 9".dispatcher.window.move = {
          workspace = "9";
          follow = true;
        };
        "SUPER + SHIFT + 0".dispatcher.window.move = {
          workspace = "0";
          follow = true;
        };
      };
    };
}
