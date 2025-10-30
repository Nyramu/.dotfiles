{ config, lib, pkgs, ... }: with lib;

let
  theme = import ../../../../resources/themes/sunset.nix { inherit pkgs; };

  cfg = config.nyra.home.apps.terminals;
in
{
  options.nyra.home.apps.terminals = {
    kitty.enable = mkEnableOption "kitty";
  };

  config = {
    programs.kitty = {
      enable = cfg.kitty.enable;
      enableGitIntegration = true;
      shellIntegration.enableZshIntegration = config.nyra.home.shells.zsh.enable;
      settings = {
        shell_integration = "enabled";
        confirm_os_window_close = 0;
        # Does not work for some reason
        #startup_session = "/home/nyramu/.dotfiles";
        allow_remote_control = "no";
        listen_on = "none";

        scrollbar = "scrolled";
        scrollbar_interactive = "yes";
        scrollbar_jump_on_click = "yes";
        scrollbar_handle_color = "#${theme.palette.base0A}";
        background_blur = 0;
        cursor_trail = 60;
        cursor_trail_color = "#${theme.palette.base0A}";
      };
      # Fix for Stylix overriding normal settings
      extraConfig = "
        selection_background #${theme.palette.base02}
        selection_foreground none
        color8 #${theme.palette.base03} 
      ";
    };
  };
}
