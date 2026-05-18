{ self, lib, ... }:
{
  flake.modules.nixos = {
    gaming.imports = [ self.modules.nixos.lsfg ];

    lsfg =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.gaming.lsfg;
      in
      {
        options.nyra.gaming.lsfg = {
          enable = lib.mkEnableOption "lsfg-vk";
        };

        config = lib.mkIf (cfg.enable) {
          environment.systemPackages = with pkgs; [
            lsfg-vk
            lsfg-vk-ui
          ];
        };
      };
  };
}
