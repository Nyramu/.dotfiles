{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

let
  cfg = config.nyra.gaming.eden;
in
{
  imports = [
    inputs.eden.homeModules.default
  ];

  options.nyra.gaming.eden = {
    enable = lib.mkEnableOption "eden";
  };

  config = {
    home.packages = lib.optionals cfg.enable [ pkgs.nsz ];

    programs.eden.enable = cfg.enable;
  };
}
