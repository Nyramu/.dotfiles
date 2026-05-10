{ self, lib, ... }:
{
  flake.modules.nixos = {
    gaming.imports = [ self.modules.nixos.steam ];

    steam =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.gaming.steam;
      in
      {
        options.nyra.gaming.steam = {
          enable = lib.mkEnableOption "steam";
        };

        config = lib.mkIf (cfg.enable) {
          boot.kernelModules = [ "ntsync" ];
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
      };
  };
}
