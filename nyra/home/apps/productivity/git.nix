{ config, lib, pkgs, userSettings, ... }: with lib;

let 
  shellCfg = config.nyra.home.shells;
  cfg = config.nyra.home.apps.miscellaneous.git;
in
{
  options.nyra.home.apps.miscellaneous.git = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "enables git and some utility tools";
    };
  };

  config = {
    programs.git = {
      enable = cfg.enable;
      settings.user = {
        inherit (userSettings) name;
        inherit (userSettings) email;
      };
    };

    programs.gh = {
      enable = cfg.enable;
      extensions = [ pkgs.gh-dash ];
      settings = {
        git_protocol = "ssh";
        editor = "nvim"; # TODO: check if it supports something like "$EDITOR"
      };
    };

    programs.lazygit = {
      enable = cfg.enable;
      enableZshIntegration = shellCfg.zsh.enable;
    };
  };
}
