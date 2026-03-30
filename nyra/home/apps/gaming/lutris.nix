{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nyra.home.apps.lutris;
in
{
  options.nyra.home.apps.lutris = {
    enable = lib.mkEnableOption "lutris";
  };

  config = {
    programs.lutris = {
      enable = cfg.enable;
      steamPackage = pkgs.steam;
      protonPackages = [ pkgs.proton-ge-bin ];
      winePackages = [ pkgs.wineWow64Packages.full ];
      extraPackages = with pkgs; [
        winetricks
        gamemode
        umu-launcher
      ];
      runners = {
        cemu.package = pkgs.cemu;
      };
    };
  };
}
