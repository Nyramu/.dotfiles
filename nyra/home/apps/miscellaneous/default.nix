{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.home.apps.miscellaneous; 
in
{
  imports = [
    ./yazi.nix
    ./btop.nix
    ./fastfetch.nix
    ./zellij.nix
    ./git.nix
  ];

  options.nyra.home.apps.miscellaneous = {
    ptracer.enable = mkEnableOption "packet tracer";
    packages = mkOption {
      type = types.listOf types.package;
      default = [];
    };
  };

  config = {
    home.packages = cfg.packages ++
      optionals (cfg.ptracer.enable) [ (pkgs.callPackage ../../../custom-derivations/packet-tracer.nix {}) ];

    nixpkgs.config.permittedInsecurePackages = with pkgs; 
      optionals (cfg.ptracer.enable) [ "ciscoPacketTracer9-9.0.0" ];
  };
}
