{ self, lib, ... }:
{
  flake.modules.nixos = {
    gaming.imports = [ self.modules.nixos.cemu ];

    cemu =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.gaming.cemu;
      in
      {
        options.nyra.gaming.cemu = {
          enable = lib.mkEnableOption "Cemu Emulator";
          package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.cemu;
            description = "The cemu package to use";
          };
          ukmm.enable = lib.mkEnableOption "UKMM (BoTW Mod Manager)";
        };

        config = lib.mkIf (cfg.enable) {
          environment.systemPackages = [ cfg.package ] ++ lib.optional (cfg.ukmm.enable) pkgs.ukmm;
        };
      };
  };
}
