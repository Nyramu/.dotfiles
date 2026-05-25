{ self, lib, ... }:
{
  flake.modules.nixos = {
    gaming.imports = [ self.modules.nixos.lsfg ];

    lsfg =
      { config, host, ... }:

      let
        cfg = config.nyra.gaming.lsfg;
      in
      {
        options.nyra.gaming.lsfg = {
          enable = lib.mkEnableOption "lsfg-vk";
        };

        config = lib.mkIf (cfg.enable) {
          environment.systemPackages = with self.packages.${host.system}; [
            lsfg-vk
            lsfg-vk-ui
          ];
        };
      };
  };
}
