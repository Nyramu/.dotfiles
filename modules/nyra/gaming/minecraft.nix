{ self, lib, ... }:
{
  flake.modules.homeManager = {
    gaming.imports = [ self.modules.homeManager.minecraft ];

    minecraft =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.gaming.minecraft;
      in
      {
        imports = [ self.modules.homeManager.java ];

        options.nyra.gaming.minecraft = {
          enable = lib.mkEnableOption "minecraft";
        };

        config = lib.mkIf (cfg.enable) {
          home.packages = with pkgs; [
            (prismlauncher.override {
              jdks = [ config.nyra.miscellaneous.java.package ];
            })
          ];

          nyra.miscellaneous.java.enable = lib.mkDefault true;
        };
      };
  };
}
