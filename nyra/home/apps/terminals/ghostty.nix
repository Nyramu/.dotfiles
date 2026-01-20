{ config, lib, ... }:

let
  shells = config.nyra.home.shells;
in
{
  options.nyra.home.apps.ghostty = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = config.nyra.home.apps.defaultTerminal == "ghostty";
      description = "ghostty";
    };
  };

  config = {
    programs.ghostty = {
      enable = config.nyra.home.apps.ghostty.enable;
      enableZshIntegration = shells.zsh.enable;
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
