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

  config = lib.mkIf config.nyra.system.apps.steam.enable {
    boot.kernelModules = [
      "ntsync"
    ];
    programs.steam = {
      enable = true;
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
