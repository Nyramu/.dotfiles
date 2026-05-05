{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nyra.hardware.amd;
in
{
  options.nyra.hardware.amd = {
    enable = lib.mkEnableOption "AMD Optimizations";
    ryzen-smu.enable = lib.mkEnableOption "ryzen-smu";
    ryzenadj.enable = lib.mkEnableOption "ryzenadj";
  };

  config = lib.mkIf (cfg.enable) {
    hardware = {
      amdgpu.initrd.enable = true;
      amdgpu.overdrive.enable = true;
      amdgpu.opencl.enable = true;
      graphics.extraPackages = with pkgs; [
        libva
      ];
      cpu.amd.ryzen-smu.enable = cfg.ryzen-smu.enable;
    };
    nixpkgs.config.rocmSupport = true;

    environment.systemPackages = lib.optionals (cfg.ryzenadj.enable) [ pkgs.ryzenadj ];
  };
}
