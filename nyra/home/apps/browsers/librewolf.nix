{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.home.apps.browsers;
in
{
  options.nyra.home.apps.browsers = {
    librewolf.enable = mkOption {
      type = types.bool;
      default = cfg.default == "librewolf";
      description = "librewolf";
    };
  };

  config = {
    programs.librewolf = {
      enable = cfg.librewolf.enable;
      profiles.nyramu.isDefault = true;
      # TODO: add librewolf config
    };
  };
}

