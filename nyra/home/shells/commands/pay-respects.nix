{ config, lib, ... }:

let
  shells = config.nyra.shells;
  cfg = config.nyra.shells.commands.payRespects;
in
{
  options.nyra.shells.commands.payRespects = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "pay-respects";
    };
  };

  config = {
    programs.pay-respects = {
      enable = cfg.enable;
      enableZshIntegration = shells.zsh.enable;
      enableNushellIntegration = shells.nushell.enable;
      options = [
        "--alias f"
        "--alias fuck"
      ];
    };
  };
}
