# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../base/configuration.nix
    ./common.nix
  ];

  # Apps
  nyra.system.apps = {
    miscellaneous = {
      ptracer.enable = true;
    };
  };

  # Theming and fonts
  nyra.system.login.userIcon = "nyramu";
  nyra.system.login.sddm.theme = "silentSDDM"; # Set SDDM theme
  nyra.system.fonts = with pkgs; [ nerd-fonts.jetbrains-mono ]; # Set fonts

  # Choose audio server
  nyra.system.hardware.audio.server = "pulseaudio";

  # Enable Hyprland
  nyra.system.desktops.hyprland.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "it";
    variant = "";
  };
  # Configure console keymap
  console.keyMap = "it2";
}
