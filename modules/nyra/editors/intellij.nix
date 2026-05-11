{ self, lib, ... }:
{
  flake.modules.homeManager = {
    editors.imports = [ self.modules.homeManager.intellij ];

    intellij =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.editors.intellij;
      in
      {
        options.nyra.editors.intellij = {
          enable = lib.mkEnableOption "intellij";
        };

        config = lib.mkIf (cfg.enable) {
          home.packages = [
            pkgs.jetbrains.idea
            pkgs.openjdk25
          ];
        };
      };
  };
}
