{ config, lib, ... }: with lib;

let
  cfg = config.nyra.home.apps.miscellaneous;
in
{
  imports = [
    ./yazi.nix
    ./btop.nix
    ./fastfetch.nix
  ];

  options.nyra.home.apps.miscellaneous = {
    not-configurable = mkOption {
      type = types.listOf types.package;
      default = [];
    };
  };

  config = {
    home.packages = cfg.not-configurable;
  };
}
