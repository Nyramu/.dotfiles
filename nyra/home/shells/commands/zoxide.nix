{ config, lib, ... }: with lib;

let
  cfg = config.nyra.home.shells;
in
{
  options.nyra.home.shells.commands.zoxide = {
    enable = mkEnableOption "zoxide";
  };

  config = {
    programs.zoxide = {
      enable = cfg.commands.zoxide.enable;
      enableZshIntegration = cfg.zsh.enable;
      options = [];
    };
  };
}

