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
          ukmm.enable = lib.mkEnableOption "UKMM (BoTW Mod Manager)";
        };

        config = lib.mkIf (cfg.enable) {
          environment.systemPackages = with pkgs; [ cemu ] ++ lib.optionals (cfg.ukmm.enable) [ ukmm ];
        };
      };
  };
}
