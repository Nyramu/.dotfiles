{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nyra.apps.editors.intellij;
in
{
  options.nyra.apps.editors.intellij = {
    enable = lib.mkEnableOption "intellij";
  };

  config = {
    home.packages = lib.optionals (cfg.enable) [
      pkgs.jetbrains.idea
      pkgs.openjdk25
    ];
  };
}
