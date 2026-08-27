{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.modules.nixos = {
    gaming.imports = [ self.modules.nixos.cemu ];

    cemu =
      {
        config,
        pkgs,
        host,
        ...
      }:

      let
        cfg = config.nyra.gaming.cemu;
        cemu = inputs.cemu-nix.packages.${host.system}.default or pkgs.cemu;
      in
      {
        options.nyra.gaming.cemu = {
          enable = lib.mkEnableOption "Cemu Emulator";
          package = lib.mkOption {
            type = lib.types.package;
            default = cemu;
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
