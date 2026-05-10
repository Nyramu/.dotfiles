{ self, lib, ... }:
{
  flake.modules.homeManager = {
    gaming.imports = [ self.modules.homeManager.lutris ];

    lutris =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.gaming.lutris;
      in
      {
        options.nyra.gaming.lutris = {
          enable = lib.mkEnableOption "lutris";
        };

        config = lib.mkIf (cfg.enable) {
          programs.lutris = {
            enable = true;
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
      };
  };
}
