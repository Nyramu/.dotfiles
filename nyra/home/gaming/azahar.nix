{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nyra.gaming.azahar;
in
{
  options.nyra.gaming.azahar = {
    enable = lib.mkEnableOption "azahar";
  };

  config = {
    home.packages = lib.optionals (cfg.enable) [
      pkgs.azahar
    ];
  };
}
