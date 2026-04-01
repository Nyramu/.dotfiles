{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nyra.system.amd;
in
{
  options.nyra.system.amd = rec {
    enable = lib.mkEnableOption "AMD Optimizations";
    ryzen-smu.enable = lib.mkOption {
      type = lib.types.bool;
      default = enable;
      description = "ryzen-smu";
    };
    ryzenadj.enable = lib.mkOption {
      type = lib.types.bool;
      default = enable;
      description = "ryzenadj";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware = {
      amdgpu.initrd.enable = true;
      amdgpu.overdrive.enable = true;
      amdgpu.opencl.enable = true;
      graphics.extraPackages = with pkgs; [
        libva
        rocmPackages.clr
      ];
      cpu.amd.ryzen-smu.enable = cfg.ryzen-smu.enable;
    };
    nixpkgs.config.rocmSupport = true;

    environment.systemPackages = lib.optionals cfg.ryzenadj.enable [ pkgs.ryzenadj ];
  };
}
