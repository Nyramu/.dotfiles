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

  # Theming and fonts
  nyra.system.sddm.avatar = "nyramu";
  nyra.system.fonts = with pkgs; [ nerd-fonts.jetbrains-mono ]; # Set fonts

  # Apps
  nyra.system.apps = {
    steam.enable = true;
    gamemode.enable = true;
    gamescope.enable = true;
    lossless-scaling.enable = true;
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # AMD management tools and features
  nyra.system.amd = {
    enable = true;
    ryzen-smu.enable = true;
    ryzenadj.enable = false;
  };

  # Virtualisation
  # users.users.nyramu.extraGroups = [ "libvirtd" ];
  # virtualisation.libvirtd.enable = true;

  # Enable fingerprints support, register one running
  # fprintd-enroll <user>
  nyra.system.fingerprint.enable = true;

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
}
