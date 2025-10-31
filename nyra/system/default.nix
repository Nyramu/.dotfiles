{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.system;
in
{
  imports = [
    ./apps
    ./audio
    ./desktops
    ./fonts
    ./input
    ./login
    ./security
    ./theme
  ];

  options.nyra.system = {
    amd-features = mkOption {
      type = types.listOf (types.enum [ "ryzen-smu" "rocm" ]);
      default = [];
      description = "AMD features like rocm and ryzen-smu";
    };
  };

  config = {
    nixpkgs.config.rocmSupport = elem "rocm" cfg.amd-features;
    hardware.cpu.amd.ryzen-smu.enable = elem "ryzen-smu" cfg.amd-features;
  };
}
