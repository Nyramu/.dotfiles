{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:

let
  shells = config.nyra.home.shells;
  cfg = config.nyra.home.apps.git;
in
{
  options.nyra.home.apps.git = {
    enable = lib.mkOption {
      type = lib.types.bool;
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
        editor = "$EDITOR"; # TODO: check if it supports something like "$EDITOR"
      };
    };

    programs.lazygit = {
      enable = cfg.enable;
      enableZshIntegration = shells.zsh.enable;
    };
  };
}
