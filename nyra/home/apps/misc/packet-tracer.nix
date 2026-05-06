{
  config,
  lib,
  pkgs,
  ...
}:
with lib;

let
  cfg = config.nyra.apps.misc.ptracer;
in
{
  options.nyra.apps.misc.ptracer = {
    enable = mkEnableOption "packet tracer";
  };

  config = lib.mkIf (cfg.enable) {
    home.packages = [
      (pkgs.callPackage ../../../custom-derivations/packet-tracer.nix { })
    ];

    nixpkgs.config.permittedInsecurePackages = [ "ciscoPacketTracer9-9.0.0" ];
  };

}
