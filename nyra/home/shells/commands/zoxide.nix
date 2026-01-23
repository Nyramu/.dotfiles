{ config, lib, ... }:

let
  shells = config.nyra.shells;
  cfg = config.nyra.home.shells.commands.zoxide;
in
{
  options.nyra.home.shells.commands.zoxide = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "zoxide";
    };
  };

  config = {
    programs.zoxide = {
      enable = cfg.enable;
      enableZshIntegration = shells.zsh.enable;
      enableNushellIntegration = shells.nushell.enable;
      options = [ "--cmd cd" ];
    };
  };
}
