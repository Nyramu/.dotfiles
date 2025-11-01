# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:

{
  imports = [ 
      ./hardware-configuration.nix
      ../base/configuration.nix
  ];

  # Theming
  nyra.theme = {
    enable = true;
    defaultTheme = "sunset";
  };
  nyra.system.login.sddm.theme = "silentSDDM";

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Enable AMD rocm support and ryzen-smu
  nyra.system.amd-features = [ "rocm" "ryzen-smu" ];

  # Choose Pipewire instead of Pulseaudio
  nyra.system.audio.server = "pipewire";

  # Enable fingerprints support
  nyra.system.security.fprint.enable = true;

  # Enable Hyprland
  nyra.system.desktops.hyprland.enable = true;

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
