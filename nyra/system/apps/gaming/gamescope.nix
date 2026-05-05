{ config, lib, ... }:

let
  nyraSettings = config.nyra.settings;
  monitor = nyraSettings.monitor;
in
{
  options.nyra.system.apps.gamescope = {
    enable = lib.mkEnableOption "gamescope";
  };

  config = lib.mkIf config.nyra.system.apps.gamescope.enable {
    programs.gamescope = {
      enable = true;
      capSysNice = true;
      env = {
        # IMPORTANT: gamescope uses american keyboard layout by default
        "XKB_DEFAULT_LAYOUT" = config.services.xserver.xkb.layout;
      };
      args = [
        "-f"
        "-W" "${monitor.width}"
        "-H" "${monitor.height}"
        "-w" "${monitor.width}"
        "-h" "${monitor.height}"
        "-r" "${monitor.refreshRate}"
        #"-e"          # enable steam integration
        "--force-windows-fullscreen"
      ];
    };
  };
}
