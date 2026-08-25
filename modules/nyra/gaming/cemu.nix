{ self, lib, ... }:
{
  flake.modules.homeManager = {
    gaming.imports = [ self.modules.homeManager.cemu ];

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
          home.packages = with pkgs; [ cemu ] ++ lib.optionals (cfg.ukmm.enable) [ ukmm ];
        };
      };
  };
}
