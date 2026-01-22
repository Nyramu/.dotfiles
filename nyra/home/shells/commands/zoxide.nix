{ config, lib, ... }:
with lib;

let
  cfg = config.nyra.home.shells;
in
{
  options.nyra.home.shells.commands.zoxide = {
    enable = mkOption {
      type = types.bool;
      default = cfg.zsh.enable;
      description = "zoxide";
    };
  };

  config = {
    programs.zoxide = {
      enable = cfg.commands.zoxide.enable;
      enableZshIntegration = cfg.zsh.enable;
      enableNushellIntegration = cfg.nushell.enable;
      options = [ "--cmd cd" ];
    };
  };
}
