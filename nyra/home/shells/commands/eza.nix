{ config, lib, ... }: with lib;

let
  cfg = config.nyra.home.shells;
in
{
  options.nyra.home.shells.commands.eza = {
    enable = mkEnableOption "eza";
  };

  config = {
    programs.eza = {
      enable = cfg.commands.eza.enable;
      enableZshIntegration = cfg.zsh.enable;
      git = true;
      icons = "always";
      colors = "always";

    };
  };
}


