{ config, lib, ... }:

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
        "-W" "1920"
        "-H" "1200"
        "-w" "1920"
        "-h" "1200"
        "-r" "60"
        #"-e"          # enable steam integration
        "--force-windows-fullscreen"
      ];
    };
  };
}
