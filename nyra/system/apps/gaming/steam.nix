{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.nyra.system.apps.steam = {
    enable = lib.mkEnableOption "steam";
  };

  config = {
    programs.steam = {
      enable = config.nyra.system.apps.steam.enable;
      gamescopeSession = {
        enable = true;
      };
      protontricks.enable = true;
      extest.enable = true;
      extraPackages = with pkgs; [
        xdg-utils
        desktop-file-utils
      ];
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };
  };
}
