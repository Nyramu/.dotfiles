{ self, lib, ... }:
{
  flake.modules.homeManager = {
    terminals.imports = [ self.modules.homeManager.ghostty ];

    ghostty =
      { config, shell, ... }:

      let
        cfg = config.nyra.terminals.ghostty;
        default = config.nyra.terminals.default;
      in
      {
        options.nyra.terminals.ghostty = {
          enable = lib.mkEnableOption "ghostty";
        };

        config = {
          programs.ghostty = lib.mkIf (cfg.enable) {
            enable = true;
            enableBashIntegration = (shell == "bash");
            enableZshIntegration = (shell == "zsh");
            enableFishIntegration = (shell == "fish");
            systemd.enable = true;
            settings = {
              working-directory = "inherit";
              confirm-close-surface = false;
              right-click-action = "copy-or-paste";
              clipboard-read = "allow";
              clipboard-write = "allow";
              clipboard-paste-protection = false;
            };
          };
          nyra.terminals.ghostty.enable = lib.mkDefault (default == "ghostty");
        };
      };
  };
}
