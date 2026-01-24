{
  config,
  lib,
  pkgs,
  ...
}:

let
  nyraSettings = config.nyra.settings;
  shells = config.nyra.shells;
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
        inherit (nyraSettings) name;
        inherit (nyraSettings) email;
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
      enableNushellIntegration = shells.nushell.enable;
    };
  };
}
