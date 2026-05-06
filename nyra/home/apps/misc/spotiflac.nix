{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nyra.apps.misc.spotiflac;
in

{
  options.nyra.apps.misc.spotiflac = {
    enable = lib.mkEnableOption "spotiflac";
  };

  config = lib.mkIf (cfg.enable) {
    home.packages = [
      (pkgs.callPackage ../../../custom-derivations/spotiflac.nix { })
    ];
  };
}
