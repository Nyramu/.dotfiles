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

  # Local server configuration
  nyra.system = {
    mysql.enable = true;
    httpd.enable = true;
  };

  # Theming and fonts
  nyra.system.sddm.avatar = "nyramu";
  nyra.system.fonts = with pkgs; [ nerd-fonts.jetbrains-mono ]; # Set fonts

  # AMD management tools and features
  nyra.system.amd = {
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
