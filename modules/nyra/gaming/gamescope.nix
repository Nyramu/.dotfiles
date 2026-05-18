{ self, lib, ... }:
{
  flake.modules.nixos = {
    gaming.imports = [ self.modules.nixos.gamescope ];

    gamescope =
      { config, ... }:

      let
        cfg = config.nyra.gaming.gamescope;
      in
      {
        options.nyra.gaming.gamescope = {
          enable = lib.mkEnableOption "gamescope";
        };

        config = lib.mkIf (cfg.enable) {
          programs.gamescope = {
            enable = true;
            capSysNice = true;
            env = {
              "XKB_DEFAULT_LAYOUT" = config.services.xserver.xkb.layout;
            };
            args = [
              "-f"
              "--force-windows-fullscreen"
            ];
          };
        };
      };
  };
}
