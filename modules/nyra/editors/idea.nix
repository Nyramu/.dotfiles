{ self, lib, ... }:
{
  flake.modules.homeManager = {
    editors.imports = [ self.modules.homeManager.idea ];

    idea =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.editors.idea;
      in
      {
        options.nyra.editors.idea = {
          enable = lib.mkEnableOption "Intellij IDEA";
        };

        config = lib.mkIf (cfg.enable) {
          home.packages = [
            pkgs.jetbrains.idea
          ];

          nyra.miscellaneous.java.enable = lib.mkDefault true;

          hyprnix.settings.bind = lib.mkIf (config.nyra.desktops.hyprland.enable) {
            "SUPER + I".dispatcher.exec_cmd = "idea";
          };
        };
      };
  };
}
