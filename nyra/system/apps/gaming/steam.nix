{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.system.apps.gaming;
in
{
  options.nyra.system.apps.gaming = {
    steam.enable = mkEnableOption "steam";
    lossless-scaling.enable = mkEnableOption "lsfg-vk";
    gamemode.enable = mkEnableOption "gamemode";
    gamescope.enable = mkEnableOption "gamescope";
  };

  config = {
    # Needed to make the renice setting work
    users.users.nyramu.extraGroups = optionals cfg.gamemode.enable ["gamemode"];

    programs.steam = {
      enable = cfg.steam.enable;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };

    environment.systemPackages = with pkgs; [
      protonup-ng
    ] ++ optionals (cfg.lossless-scaling.enable) [ lsfg-vk lsfg-vk-ui ];

    programs.gamemode = {
      enable = cfg.gamemode.enable;
      enableRenice = true;
      settings = {
        general = {
          renice = 10;
          igpu_desiredgov = "performance";
          #igpu_power_threshold = -1;
        };
        #gpu = {
        #  amd_performance_level = "high";
        #};
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
