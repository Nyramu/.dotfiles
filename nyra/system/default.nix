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
    ./login
    ./security
    ./theme
    ./fonts.nix
  ];

  options.nyra.system = {
    amd-features = mkOption {
      type = types.listOf (types.enum [ "rocm" "ryzen-smu" ]);
      default = [];
      description = "AMD features like rocm and ryzen-smu";
    };
  };

  config = {
    nixpkgs.config.rocmSupport = elem "rocm" cfg.amd-features;
    hardware.cpu.amd.ryzen-smu.enable = elem "ryzen-smu" cfg.amd-features;
  };
}
