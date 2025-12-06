{ config, lib, ... }: with lib;

let
  cfg = config.nyra.home.shells;
in
{
  options.nyra.home.shells.commands.eza = {
    enable = mkOption {
      type = types.bool;
      default = cfg.zsh.enable;
      description = "eza";
    };
  };

  config = {
    programs.eza = {
      enable = cfg.commands.eza.enable;
      enableZshIntegration = cfg.zsh.enable;
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


