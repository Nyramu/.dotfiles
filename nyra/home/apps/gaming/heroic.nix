{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.nyra.home.apps.heroic = {
    enable = lib.mkEnableOption "heroic";
  };

  config = {
    home.packages = lib.optionals config.nyra.home.apps.heroic.enable [ pkgs.heroic ];
  };
}
