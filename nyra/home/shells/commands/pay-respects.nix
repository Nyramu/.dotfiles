{ config, lib, ... }:

let
  shells = config.nyra.shells;
  cfg = config.nyra.home.shells.commands.pay-respects;
in
{
  options.nyra.home.shells.commands.pay-respects = {
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
