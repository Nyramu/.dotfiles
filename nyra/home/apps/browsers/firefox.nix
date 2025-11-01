{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.home.apps.browsers;
in
{
  options.nyra.home.apps.browsers = {
    firefox = {
      enable = mkOption {
        type = types.bool;
        default = cfg.default == "firefox";
        description = "firefox";
      };
    };
  };

  config = {
    home.packages = optionals cfg.firefox.enable [pkgs.firefox];
  };
}

