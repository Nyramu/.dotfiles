{
  config,
  lib,
  ...
}:

let
  cfg = config.nyra.apps.terminals;
  stylix-palette = config.stylix.base16Scheme;
  shells = config.nyra.shells;
in
{
  options.nyra.apps.terminals.kitty = {
    enable = lib.mkEnableOption "kitty";
  };

  config = {
    nyra.apps.terminals.kitty.enable = lib.mkDefault (cfg.default == "kitty");
    programs.kitty = {
      enable = cfg.kitty.enable;
      enableGitIntegration = true;
      shellIntegration = {
        enableZshIntegration = shells.zsh.enable;
        # enableNushellIntegration = shells.nushell.enable;
      };
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

        window_padding_width = "0 8";
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
