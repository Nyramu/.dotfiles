# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, lib, ... }:

{
  imports = [ ../../nyramu/nixos/default.nix ];

  # Use latest kernel.
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nyramu = {
    isNormalUser = true;
    description = "Nyramu";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ neovim ];
  };

  # Default shell
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    git
    curl
    usbutils
    kitty
  ];

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable AMD rocm support and ryzen-smu
  nixpkgs.config.rocmSupport = true;
  hardware.cpu.amd.ryzen-smu.enable = true;

  # Support MTP devices
  services.gvfs.enable = true;

  # Support NTFS file system
  boot.supportedFilesystems = [ "ntfs" ];

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "it_IT.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true; 

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Storage optimization
  nix.settings.auto-optimise-store = true;

  # Allow unfree packages and experimental features
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

