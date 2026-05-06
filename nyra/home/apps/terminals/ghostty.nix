{ config, lib, ... }:

let
  shells = config.nyra.shells;
  cfg = config.nyra.apps.terminals;
in
{
  options.nyra.apps.terminals.ghostty = {
    enable = lib.mkEnableOption "ghostty";
  };

  config = {
    nyra.apps.terminals.ghostty.enable = lib.mkDefault (cfg.default == "ghostty");
    programs.ghostty = {
      enable = cfg.ghostty.enable;
      enableZshIntegration = shells.zsh.enable;
      # enableNushellIntegration = shells.nushell.enable;
      settings = {
        background-blur = false;
        working-directory = "inherit";
        confirm-close-surface = false;
        right-click-action = "copy-or-paste";
        clipboard-read = "allow";
        clipboard-write = "allow";
        clipboard-paste-protection = false;
      };
    };
  };
}
