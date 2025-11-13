{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.system.hardware.amd;
in
{
  options.nyra.system.hardware.amd = {
    rocm.enable = mkEnableOption "rocm";
    ryzen-smu.enable = mkEnableOption "ryzen-smu";
    ryzenadj.enable = mkEnableOption "ryzenadj";
  };

  config = {
    nixpkgs.config.rocmSupport = cfg.rocm.enable;
    hardware.cpu.amd.ryzen-smu.enable = cfg.ryzen-smu.enable;

    environment.systemPackages = 
      optionals cfg.ryzenadj.enable [ pkgs.ryzenadj ];
  };
}
