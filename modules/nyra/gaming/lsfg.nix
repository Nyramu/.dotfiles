{ self, lib, ... }:
{
  flake.modules.nixos = {
    gaming.imports = [ self.modules.nixos.lsfg ];

    lsfg =
      { config, dotpkgs, ... }:

      let
        cfg = config.nyra.gaming.lsfg;
      in
      {
        options.nyra.gaming.lsfg = {
          enable = lib.mkEnableOption "LSFG-VK";
        };

        config = lib.mkIf (cfg.enable) {
          environment.systemPackages = with dotpkgs; [
            lsfg-vk
            lsfg-vk-ui
          ];
        };
      };
  };
}
