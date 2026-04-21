# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, pkgs, ... }:

{
  imports = [
    ./common.nix
    ../base/configuration.nix
    ./hardware-configuration.nix
  ];

  # Use dongle instead of the internal bluetooth controller
  nyra.system.bluetooth.onlyUseDongle = true;

  # Theming and fonts
  nyra.system.fonts = with pkgs; [ nerd-fonts.jetbrains-mono ]; # Set fonts

  # Apps
  nyra.system.apps = {
    steam.enable = true;
    gamemode.enable = true;
    gamescope.enable = true;
    lossless-scaling.enable = true;
  };

  # MySQL
  nyra.system.mysql.enable = false;
  nyra.system.httpd.enable = false;

  # Use CachyOS Zen4 LTO kernel.
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-zen4;
  nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];

  # AMD management tools and features
  nyra.system.amd = {
    enable = true;
  };

  # Enable fingerprints support, register one running
  # fprintd-enroll <user>
  nyra.system.fingerprint.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "it";
    variant = "";
  };
  # Configure console keymap
  console.keyMap = "it2";

  # Say git gud to Copilot button
  services.keyd = {
    enable = true;
    keyboards = {
      dell-wmi = {
        ids = [ "*" ];
        settings = {
          main = {
            "leftmeta+leftshift+f23" = "rightmeta";
          };
        };
      };
    };
  };
}
