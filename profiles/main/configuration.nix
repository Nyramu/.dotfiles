# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports = [
    ./common.nix
    ../base/configuration.nix
    ./hardware-configuration.nix
  ];

  # Use dongle instead of the internal bluetooth controller
  nyra.hardware.bluetooth.useDongleOnly = true;

  # Theming and fonts
  nyra.fonts = with pkgs; [ nerd-fonts.jetbrains-mono ]; # Set fonts

  # Apps
  nyra.gaming = {
    steam.enable = true;
    gamemode.enable = true;
    gamescope.enable = true;
    lsfg.enable = true;
  };

  # MySQL
  nyra.services.mysql.enable = false;
  nyra.services.httpd.enable = false;

  # Use CachyOS Latest Zen4 LTO kernel.
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-zen4;

  # AMD management tools and features
  nyra.hardware.amd.enable = true;

  # Enable fingerprints support, register one running
  # fprintd-enroll <user>
  nyra.security.fingerprint.enable = true;

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
