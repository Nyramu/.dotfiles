{ self, lib, ... }:
{
  flake.modules.homeManager = {
    terminals.imports = [ self.modules.homeManager.ghostty ];

    ghostty =
      {
        config,
        nyralib,
        shell,
        ...
      }:

      let
        cfg = config.nyra.terminals.ghostty;
      in
      {
        options.nyra.terminals.ghostty = {
          enable = nyralib.mkDefaultDependentOption "Ghostty" "nyra.terminals.default" "ghostty";
        };

        config = lib.mkIf (cfg.enable) {
          programs.ghostty = {
            enable = true;
            enableBashIntegration = (shell == "bash");
            enableZshIntegration = (shell == "zsh");
            enableFishIntegration = (shell == "fish");
            systemd.enable = true;
            settings = {
              selection-clear-on-copy = false;
              cursor-style = "bar";
              cursor-style-blink = true;
              cursor-click-to-move = true;
              mouse-hide-while-typing = true;
              notify-on-command-finish = "unfocused";
              notify-on-command-finish-action = "no-bell,notify";
              working-directory = "inherit";
              window-inherit-working-directory = true;
              tab-inherit-working-directory = false;
              split-inherit-working-directory = true;
              confirm-close-surface = false;
              right-click-action = "copy-or-paste";
              clipboard-read = "allow";
              clipboard-write = "allow";
              clipboard-paste-protection = true;
              auto-update = "off";
              window-padding-x = 12;
              window-padding-y = 8;
            };
          };
        };
      };
  };
}
