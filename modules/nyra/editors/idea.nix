{ self, lib, ... }:
{
  flake.modules.homeManager = {
    editors.imports = [ self.modules.homeManager.idea ];

    idea =
      {
        config,
        nyralib,
        pkgs,
        ...
      }:

      let
        cfg = config.nyra.editors.idea;
      in
      {
        options.nyra.editors.idea = {
          enable = nyralib.mkDefaultDependentOption "Intellij IDEA" "nyra.editors.default" "idea";
        };

        config = lib.mkIf (cfg.enable) {
          home.packages = [
            pkgs.jetbrains.idea
          ];

          nyra.miscellaneous.java.enable = lib.mkForce true;

          hyprnix.settings.bind = lib.mkIf (config.nyra.desktops.hyprland.enable) {
            "SUPER + I".dispatcher.exec_cmd = "idea";
          };
        };
      };
  };
}
