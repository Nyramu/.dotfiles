{ config, lib, ... }:

let
  shells = config.nyra.shells;
  cfg = config.nyra.home.shells.commands.eza;
in
{
  options.nyra.home.shells.commands.eza = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "eza";
    };
  };

  config = {
    programs.eza = {
      enable = cfg.enable;
      enableZshIntegration = shells.zsh.enable;
      enableNushellIntegration = shells.nushell.enable;
      git = true;
      icons = "always";
      colors = "always";
      extraOptions = [
        "--color-scale-mode=gradient"
        #"--no-symlinks"
        "--header"
      ];
    };
  };
}
