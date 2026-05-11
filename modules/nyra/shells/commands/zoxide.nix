{ self, lib, ... }:
{
  flake.modules.homeManager = {
    shells.imports = [ self.modules.homeManager.zoxide ];

    zoxide =
      { config, shell, ... }:

      let
        cfg = config.nyra.shells.commands.zoxide;
      in
      {
        options.nyra.shells.commands.zoxide = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
          };
        };

        config = lib.mkIf (cfg.enable) {
          programs.zoxide = {
            enable = true;
            enableBashIntegration = (shell == "bash");
            enableZshIntegration = (shell == "zsh");
            enableFishIntegration = (shell == "fish");
            options = [ "--cmd cd" ];
          };
        };
      };
  };
}
