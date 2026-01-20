{ config, lib, pkgs, ... }:

let
  cfg = config.nyra.system.apps.lossless-scaling;
in
{
  options.nyra.system.apps.lossless-scaling = {
    enable = lib.mkEnableOption "lsfg-vk";
  };

  config = {
    environment.systemPackages = with pkgs;
      lib.optionals (cfg.enable) [ lsfg-vk lsfg-vk-ui ];
  };
}

