{ self, lib, ... }:
{
  flake.modules.homeManager = {
    shells.commands.imports = [ self.modules.homeManager.payRespects ];

    payRespects =
      { config, shell, ... }:

      let
        cfg = config.nyra.shells.commands.payRespects;
      in
      {
        options.nyra.shells.commands.payRespects = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
          };
        };

        config = lib.mkIf (cfg.enable) {
          programs.pay-respects = {
            enable = true;
            enableBashIntegration = (shell == "bash");
            enableZshIntegration = (shell == "zsh");
            enableFishIntegration = (shell == "fish");
            options = [
              "--alias f"
              "--alias fuck"
            ];
          };
        };
      };
  };
}
