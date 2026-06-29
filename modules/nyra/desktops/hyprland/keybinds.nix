{ lib, ... }:
{
  flake.modules.homeManager.hyprland =
    { config, pkgs, ... }:

    let
      workspaces = map toString (lib.range 0 9);
      dirs = [
        "up"
        "down"
        "left"
        "right"
      ];

      mkWorkspaceBind = n: {
        "SUPER + ${n}".dispatcher.focus.workspace = n;
        "SUPER + SHIFT + ${n}".dispatcher.window.move = {
          workspace = n;
          follow = true;
        };
      };

      mkDirectionBind = d: {
        "SUPER + ${d}".dispatcher.focus.direction = d;
        "SUPER + SHIFT + ${d}".dispatcher.window.move = {
          direction = d;
          group_aware = true;
        };
      };
    in
    {
      hyprnix.settings.bind = {
        "SUPER + S".dispatcher.exec_cmd = "steam";

        # Screen Capture
        ## Press to start recording, then press again to stop and save
        F9.dispatcher.exec_cmd = "screen-record"; # Max quality, 60 fps
        "SUPER + F9".dispatcher.exec_cmd = "screen-record --low-quality"; # Lower bitrate, 30 fps

        ## Copy screenshot selection to clipboard without saving
        F10.dispatcher.exec_cmd = "screen-shot --selection";
        Print.dispatcher.exec_cmd = "screen-shot --selection";
        ## Copy screenshot selection to clipboard and save
        "SUPER + F10".dispatcher.exec_cmd = "screen-shot --selection --save";
        "SUPER + Print".dispatcher.exec_cmd = "screen-shot --selection --save";

        ## Copy full screenshot to clipboard without saving
        "ALT + F10".dispatcher.exec_cmd = "screen-shot";
        "ALT + Print".dispatcher.exec_cmd = "screen-shot";
        ## Copy full screenshot to clipboard and save
        "SUPER + ALT + F10".dispatcher.exec_cmd = "screen-shot --save";
        "SUPER + ALT + Print".dispatcher.exec_cmd = "screen-shot --save";

        # Miscellaneous
        ## Toggle X-Ray on floating windows
        "SUPER + X".dispatcher.window.set_prop = {
          prop = "xray";
          value = "toggle";
        };
        ## Toggle window swallowing
        "SUPER + SHIFT + S".dispatcher.window.toggle_swallow = { };

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
        "SUPER + K".dispatcher.window.close = { };
        F11.dispatcher.window.fullscreen.mode = "fullscreen";
        Home.dispatcher.window.fullscreen.mode = "fullscreen";
        "SUPER + V".dispatcher.window.float.action = "toggle";

        # Group Control
        "SUPER + G".dispatcher.group.toggle = { };
        "SUPER + SHIFT + G".dispatcher.group.lock_active = { };
        "SUPER + Tab".dispatcher.group.next = { };
        "SUPER + SHIFT + Tab".dispatcher.group.prev = { };
      }
      // lib.mergeAttrsList (map mkWorkspaceBind workspaces ++ map mkDirectionBind dirs);
    };
}
