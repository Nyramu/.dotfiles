{ config, lib, ... }:

let
  cfg = config.nyra.home.shells.commands.ripgrep;
in
{
  options.nyra.home.shells.commands.ripgrep = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "ripgrep";
    };
  };

  config = {
    programs.ripgrep = {
      enable = cfg.enable;
      arguments = [
        "--smart-case"
        "--max-columns=150"
        "--max-columns-preview"
      ];
    };
    home.shellAliases = {
      "grep" = "rg";
    };
  };
}
