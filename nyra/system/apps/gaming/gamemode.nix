{ config, lib, ... }:

let
  cfg = config.nyra.system.apps.gamemode;
in
{
  options.nyra.system.apps.gamemode = {
    enable = lib.mkEnableOption "gamemode";
  };

  config = lib.mkIf cfg.enable {
    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        general = {
          renice = 10;
        };
      };
    };
    # Needed to make the renice setting work
    users.users.${config.nyra.settings.username}.extraGroups = [ "gamemode" ];
  };
}
