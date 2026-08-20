{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.modules.nixos = {
    gaming.imports = [ self.modules.nixos.steam ];

    steam =
      {
        config,
        pkgs,
        host,
        ...
      }:

      let
        cfg = config.nyra.gaming.steam;
        proton = inputs.chaotic.packages.${host.system}.proton-ge-custom or pkgs.proton-ge-bin;
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
              enable = config.nyra.gaming.gamescope.enable;
            };
            protontricks.enable = true;
            extest.enable = true;
            extraPackages = with pkgs; [
              xdg-utils
              desktop-file-utils
            ];
            extraCompatPackages = [ proton ];
          };

          hardware.steam-hardware.enable = true;
          hardware.xpadneo.enable = true;
        };
      };
  };
}
