{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.home.apps.terminals;
in
{
  options.nyra.home.apps.terminals.ghostty = {
    enable = mkOption {
      type = types.bool;
      default = cfg.default == "ghostty";
      description = "ghostty";
    };
  };

  config = {
    programs.ghostty = {
      enable = cfg.ghostty.enable;
      enableZshIntegration = config.nyra.home.shells.zsh.enable;
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
