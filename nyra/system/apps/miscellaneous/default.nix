{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.system.apps.miscellaneous;
in
{
  imports = [];

  options.nyra.system.apps.miscellaneous = {
    ptracer.enable = mkEnableOption "packet tracer";
  };

  config = {
    environment.systemPackages = with pkgs;
      optionals (cfg.ptracer.enable) [ ciscoPacketTracer8 ];

    nixpkgs.config.permittedInsecurePackages = with pkgs; 
      optionals (cfg.ptracer.enable) [ ciscoPacketTracer8 ];
  };
}
