{
  config,
  lib,
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
      (pkgs.callPackage ../../../custom-derivations/spotiflac.nix { })
    ];
  };
}
