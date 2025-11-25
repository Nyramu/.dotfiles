{ config, lib, ... }: with lib;

let
  cfg = config.nyra.home.shells;
in
{
  options.nyra.home.shells.commands.pay-respects = {
    enable = mkEnableOption "pay-respects";
  };

  config = {
    programs.pay-respects = {
      enable = cfg.commands.pay-respects.enable;
      enableZshIntegration = cfg.zsh.enable;

      options = [ "--alias f" "--alias fuck" ];
    };
  };
}
