{ self, lib, ... }:
{
  flake.modules.nixos = {
    gaming.imports = [ self.modules.nixos.gamescope ];

    gamescope =
      { config, wayland, ... }:

      let
        cfg = config.nyra.gaming.gamescope;
      in
      {
        options.nyra.gaming.gamescope = {
          enable = lib.mkEnableOption "GameScope";
        };

        config = lib.mkIf (cfg.enable) {
          programs.gamescope = {
            enable = true;
            enableWsi = wayland.enable;
            capSysNice = true;
            env = {
              "XKB_DEFAULT_LAYOUT" = config.services.xserver.xkb.layout;
            };
            args = [
              "-f"
              "--force-windows-fullscreen"
            ]
            ++ lib.optional wayland.enable "--expose-wayland";
          };

          assertions = [
            {
              assertion = config.nyra.gaming.steam.enable;
              message = "You cannot enable GameScope without enabling Steam.";
            }
          ];
        };
      };
  };
}
