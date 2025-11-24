{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.system.hardware.amd;
in
{
  options.nyra.system.hardware.amd = {
    ryzen-smu.enable = mkEnableOption "ryzen-smu";
    ryzenadj.enable = mkEnableOption "ryzenadj";
  };

  config = {
    hardware = {
      amdgpu.initrd.enable = true;
      amdgpu.overdrive.enable = true;
      graphics.extraPackages = [ pkgs.libva ];
      cpu.amd.ryzen-smu.enable = cfg.ryzen-smu.enable;
    };
    nixpkgs.config.rocmSupport = true;

    environment.systemPackages = 
      optionals cfg.ryzenadj.enable [ pkgs.ryzenadj ];
  };
}
