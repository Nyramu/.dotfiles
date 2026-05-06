{
  config,
  lib,
  pkgs,
  ...
}:

let
  nyraSettings = config.nyra.settings;
  shells = config.nyra.shells;
  cfg = config.nyra.apps.misc.git;
in
{
  options.nyra.apps.misc.git = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enables git and some utility tools";
    };
  };

  config = lib.mkIf (cfg.enable) {
    programs.git = {
      enable = true;
      settings.user = {
        inherit (nyraSettings) name email;
      };
    };

    programs.gh = {
      enable = true;
      extensions = [ pkgs.gh-dash ];
      settings = {
        git_protocol = "ssh";
        editor = "$EDITOR"; # TODO: check if it supports something like "$EDITOR"
      };
    };

    programs.lazygit = {
      enable = true;
      enableZshIntegration = shells.zsh.enable;
      enableNushellIntegration = shells.nushell.enable;
    };
  };
}
