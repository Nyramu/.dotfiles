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
          enable = lib.mkEnableOption "cemu";
          ukmm.enable = lib.mkEnableOption "ukmm";
        };

        config = {
          home.packages =
            lib.optionals cfg.enable [ pkgs.cemu ]
            ++ lib.optionals (cfg.enable && cfg.ukmm.enable) [ pkgs.ukmm ];
        };
      };
  };
}
