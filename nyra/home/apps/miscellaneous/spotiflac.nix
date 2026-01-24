{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

let
  cfg = config.nyra.home.apps.spotiflac;
in

{
  options.nyra.home.apps.spotiflac = {
    enable = lib.mkEnableOption "spotiflac";
  };

  config = {
    home.packages = lib.mkIf (cfg.enable) [
      inputs.spotiflac.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
