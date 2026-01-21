{ config, lib, ... }:

{
  options.nyra.system.apps.gamescope = {
    enable = lib.mkEnableOption "gamescope";
  };

  config = {
    programs.gamescope = {
      enable = config.nyra.system.apps.gamescope.enable;
      env = {
        # IMPORTANT: gamescope uses american keyboard layout by default
        "XKB_DEFAULT_LAYOUT" = config.services.xserver.xkb.layout;
        "-W" = "1920";
        "-H" = "1200";
        "-w" = "1920";
        "-h" = "1200";
        "-r" = "60";
      };
      args = [
        #"--mangoapp" # mango hud (mainly for test)
        "-f"
        #"-e"          # enable steam integration
        "--force-windows-fullscreen"
      ];
    };
  };
}
