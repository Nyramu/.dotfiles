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

  # Use CachyOS Latest v3 LTO kernel.
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;

  # Local server configuration
  nyra.services = {
    mysql.enable = true;
    httpd.enable = true;
  };

  # Theming and fonts
  nyra.fonts = with pkgs; [ nerd-fonts.jetbrains-mono ]; # Set fonts

  # AMD management tools and features
  nyra.hardware.amd = {
    enable = true;
    ryzen-smu.enable = false;
    ryzenadj.enable = false;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "it";
    variant = "";
  };
  # Configure console keymap
  console.keyMap = "it";
}
