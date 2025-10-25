{ pkgs, lib, ... }:

let
  theme = import ../../aesthetics/themes/sunset.nix { inherit pkgs; };
in
{
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    shellIntegration.enableZshIntegration = true;
    settings = {
      shell_integration = "enabled";
      confirm_os_window_close = 0;
      # Does not work for some reason
      #startup_session = "/home/nyramu/.dotfiles";
      allow_remote_control = "no";
      listen_on = "none"; 

      # Appearance
      background_blur = 0;
      #selection_background = "#${theme.palette.base02}";
      #selection_foreground = "none";
      #color8 = "#${theme.palette.base03}";
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
}
