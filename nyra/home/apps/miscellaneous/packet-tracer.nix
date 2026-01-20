{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.home.apps.ptracer;
in
{
  options.nyra.home.apps.ptracer = {
    enable = mkEnableOption "packet tracer";
  };

  config = {
    home.packages = optionals (cfg.enable) [ (pkgs.callPackage ../../../custom-derivations/packet-tracer.nix {}) ];

    nixpkgs.config.permittedInsecurePackages = with pkgs; 
      optionals (cfg.enable) [ "ciscoPacketTracer9-9.0.0" ];
  };

}
