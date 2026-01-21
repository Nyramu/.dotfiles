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

  config = {
    hardware = {
      amdgpu.initrd.enable = cfg.enable;
      amdgpu.overdrive.enable = cfg.enable;
      graphics.extraPackages = lib.mkIf (cfg.enable) [ pkgs.libva ];
      cpu.amd.ryzen-smu.enable = cfg.ryzen-smu.enable;
    };
    nixpkgs.config.rocmSupport = cfg.enable;

    environment.systemPackages = lib.optionals cfg.ryzenadj.enable [ pkgs.ryzenadj ];
  };
}
