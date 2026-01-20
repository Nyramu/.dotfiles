{ config, lib, ... }:

let
  cfg = config.nyra.system.apps.gamemode;
in
{
  options.nyra.system.apps.gamemode = {
    enable = lib.mkEnableOption "gamemode";
  };

  config = {
    programs.gamemode = {
      enable = cfg.enable;
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
    # Needed to make the renice setting work
    users.users.nyramu.extraGroups = lib.optionals cfg.enable ["gamemode"];
  };
}
