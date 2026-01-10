{ config, lib, ... }: with lib;

let
  stylix-palette = config.stylix.base16Scheme;
  shellCfg = config.nyra.home.shells;
  cfg = config.nyra.home.apps.terminals;
in
{
  options.nyra.home.apps.terminals = {
    kitty.enable = mkOption {
      type = types.bool;
      default = cfg.default == "kitty";
      description = "kitty";
    };
  };

  config = {
    programs.kitty = {
      enable = cfg.kitty.enable;
      enableGitIntegration = true;
      shellIntegration.enableZshIntegration = shellCfg.zsh.enable;
      settings = {
        shell_integration = "enabled";
        confirm_os_window_close = 0;
        # Does not work for some reason
        #startup_session = /home/nyramu/.dotfiles;
        allow_remote_control = "no";
        listen_on = "none";
        sync_to_monitor = "yes";
        repaint_delay = 8;
        input_delay = 2;

        scrollbar = "scrolled";
        scrollbar_interactive = "yes";
        scrollbar_jump_on_click = "yes";
        scrollbar_handle_color = stylix-palette.base0A;
        background_blur = 0;
        cursor_trail = 60;
        cursor_trail_color = stylix-palette.base0A;
        cursor_shape_unfocused = "unchanged";
      };
      # Fix for Stylix overriding normal settings
      extraConfig = "
        selection_background ${stylix-palette.base02}
        selection_foreground none
        color8 ${stylix-palette.base03} 
      ";
    };
  };
}
