{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nyra.gaming.heroic;
in
{
  options.nyra.gaming.heroic = {
    enable = lib.mkEnableOption "heroic";
  };

  config = {
    home.packages = lib.optionals cfg.enable [ pkgs.heroic ];
  };
}
