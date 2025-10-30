{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.home.shells.commands;
in
{
  options.nyra.home.shells.commands.pay-respects = {
    enable = mkEnableOption "pay-respects";
  };

  config = {
    programs.pay-respects = {
      enable = cfg.pay-respects.enable;
      enableZshIntegration = config.nyra.home.shells.zsh.enable;

      options = [ "--alias f" "--alias fuck" ];
    };
  };
}
