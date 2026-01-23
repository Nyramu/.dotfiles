{ config, lib, ... }:

let
  cfg = config.nyra.shells;
in
{
  options.nyra.shells = {
    defaultShell = lib.mkOption {
      type = lib.types.enum [
        "zsh"
        "nushell"
      ];
      default = "zsh";
      description = "Choose default shell";
    };
    zsh.enable = lib.mkEnableOption "zsh";
    nushell.enable = lib.mkEnableOption "nushell";
  };

  config = {
    nyra.shells = {
      zsh.enable = lib.mkDefault (cfg.defaultShell == "zsh");
      nushell.enable = lib.mkDefault (cfg.defaultShell == "nushell");
    };
  };
}
