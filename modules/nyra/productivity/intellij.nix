{ self, lib, ... }:
{
  flake.modules.homeManager = {
    productivity.imports = [ self.modules.homeManager.intellij ];

    intellij =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.productivity.intellij;
      in
      {
        options.nyra.productivity.intellij = {
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
