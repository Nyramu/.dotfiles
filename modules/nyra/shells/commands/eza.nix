{ self, lib, ... }:
{
  flake.modules.homeManager = {
    shells.commands.imports = [ self.modules.homeManager.eza ];

    eza =
      { config, shell, ... }:

      let
        cfg = config.nyra.shells.commands.eza;
      in
      {
        options.nyra.shells.commands.eza = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
          };
        };

        config = lib.mkIf (cfg.enable) {
          programs.eza = {
            enable = true;
            enableBashIntegration = (shell == "bash");
            enableZshIntegration = (shell == "zsh");
            enableFishIntegration = (shell == "fish");
            git = true;
            icons = "always";
            colors = "always";
            extraOptions = [
              "--color-scale-mode=gradient"
              #"--no-symlinks"
              "--header"
            ];
          };
        };
      };
  };
}
