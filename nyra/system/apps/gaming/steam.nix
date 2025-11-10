{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.system.apps.gaming;
in
{
  options.nyra.system.apps.gaming = {
    steam.enable = lib.mkEnableOption "steam";
    gamemode.enable = lib.mkEnableOption "gamemode";
    gamescope.enable = lib.mkEnableOption "gamescope";
  };

  config = {
    #needed to make the renice setting work
    users.users.nyramu.extraGroups = lib.optionals cfg.gamemode.enable ["gamemode"];

    programs.steam = {
      enable = cfg.steam.enable;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };

    programs.gamemode = {
      enable = cfg.gamemode.enable;
      enableRenice = true;
      settings = {
        general = {
          renice = 5;
          igpu_desiredgov = "performance";
        };
      };
    };

    programs.gamescope = {
      enable = cfg.gamescope.enable;
      env = {
        "XKB_DEFAULT_LAYOUT" = config.services.xserver.xkb.layout; # IMPORTANT: gamescope uses american keyboard layout by default

        "-W" = "1920"; # window width
        "-H" = "1200"; # window height
        "-w" = "1920";
        "-h" = "1200";
        "-r" = "60";    # max refresh rate
      };
      args = [
        #"--mangoapp" # mango hud (mainly for test)
        "-f" # start at full screen
        #"-e"          # enable steam integration
        "--force-windows-fullscreen" # force internal game in full screen
      ];
    };
  };
}
