# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:

{
  imports = [ 
      ./hardware-configuration.nix
      ../base/configuration.nix
  ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Choose pipewire instead of pulseaudio
  nyra.system.audio.server = "pipewire";

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

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
        ids = ["*"];
        settings = {
          main = {
            "leftmeta+leftshift+f23" = "rightmeta";
          };
        };
      };
    };
  };

  # Mount steam-games partition (broken)
  #fileSystems."/home/nyramu/steam-games" = {
  #  device = "/dev/nvme0n1p3";
  #  options = [ "nofail" "rw" "uid = nyramu" ];
  #};
}
