{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.nyra.home.services.hypridle = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.nyra.desktops.hyprland.enable;
      description = "enable hypridle";
    };
  };

  config = lib.mkIf config.nyra.home.services.hypridle.enable {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          ignore_dbus_inhibit = false;
          ignore_systemd_inhibit = false;
          ignore_wayland_inhibit = false;
        };
        listener = [
          {
            timeout = 300;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
            ignore_inhibit = false;
          }
          {
            timeout = 600;
            on-timeout = "pidof hyprlock || hyprlock";
            ignore_inhibit = false;
          }
        ];
      };
    };
    systemd.user.services.sway-audio-idle-inhibit = {
      Unit = {
        Description = "Inhibit idle when audio is playing";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${lib.getExe pkgs.sway-audio-idle-inhibit}";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
