{ self, lib, ... }:
{
  flake.modules.homeManager = {
    services.imports = [ self.modules.homeManager.hypridle ];

    hypridle =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.services.hypridle;
        lockCmd = "noctalia-shell ipc call lockScreen lock";
      in
      {
        options.nyra.services.hypridle = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = "enable hypridle";
          };
        };

        config = lib.mkIf (cfg.enable) {
          services.hypridle = {
            enable = true;
            settings = {
              general = {
                lock_cmd = lockCmd;
                ignore_dbus_inhibit = false;
                ignore_systemd_inhibit = false;
                ignore_wayland_inhibit = false;
              };
              listener = [
                {
                  timeout = 60 * 5;
                  on-timeout = ''hyprctl dispatch 'hl.dsp.dpms({ action = "disable" })' '';
                  on-resume = ''hyprctl dispatch 'hl.dsp.dpms({ action = "enable" })' '';
                  ignore_inhibit = false;
                }
                {
                  timeout = 60 * 10;
                  on-timeout = lockCmd;
                  ignore_inhibit = false;
                }
              ];
            };
          };
          systemd.user.services.sway-audio-idle-inhibit = {
            Unit = {
              Description = "Inhibit idle when audio is playing";
              PartOf = [ config.wayland.systemd.target ];
              After = [ config.wayland.systemd.target ];
            };
            Service = {
              ExecStart = "${lib.getExe pkgs.sway-audio-idle-inhibit}";
              Restart = "on-failure";
            };
            Install = {
              WantedBy = [ config.wayland.systemd.target ];
            };
          };
        };
      };
  };
}
