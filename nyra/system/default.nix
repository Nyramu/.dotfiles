{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.system;
in
{
  imports = [
    ../common
    ./apps
    ./audio
    ./desktops
    ./fonts
    ./login
    ./security
    ./theme
  ];

  options.nyra.system = {
    amd.features = mkOption {
      type = types.listOf (types.enum [ "rocm" "ryzen-smu" ]);
      default = [];
      description = "AMD features:";
    };
    amd.ryzenadj.enable = mkEnableOption "ryzenadj";
  };

  config = {
    nixpkgs.config.rocmSupport = elem "rocm" cfg.amd.features;
    hardware.cpu.amd.ryzen-smu.enable = elem "ryzen-smu" cfg.amd.features;

    environment.systemPackages = 
      optionals cfg.amd.ryzenadj.enable [ pkgs.ryzenadj ];
  };
}
