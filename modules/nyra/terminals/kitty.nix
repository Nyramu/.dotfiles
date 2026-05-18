{ self, lib, ... }:
{
  flake.modules.homeManager = {
    terminals.imports = [ self.modules.homeManager.kitty ];

    kitty =
      { config, shell, ... }:

      let
        cfg = config.nyra.terminals.kitty;
        default = config.nyra.terminals.default;
      in
      {
        options.nyra.terminals.kitty = {
          enable = lib.mkEnableOption "kitty";
        };

        config = {
          programs.kitty = lib.mkIf (cfg.enable) {
            enable = true;
            enableGitIntegration = true;
            shellIntegration = {
              enableBashIntegration = (shell == "bash");
              enableZshIntegration = (shell == "zsh");
              enableFishIntegration = (shell == "fish");
            };
            settings = {
              shell_integration = "enabled";
              confirm_os_window_close = 0;
              allow_remote_control = "no";
              listen_on = "none";
              sync_to_monitor = "yes";
              repaint_delay = 8;
              input_delay = 2;

              scrollbar = "scrolled";
              scrollbar_interactive = "yes";
              scrollbar_jump_on_click = "yes";
              background_blur = 0;
              cursor_trail = 60;
              cursor_shape_unfocused = "unchanged";
              window_padding_width = "0 8";
            };
          };
          nyra.terminals.kitty.enable = lib.mkDefault (default == "kitty");
        };
      };
  };
}
