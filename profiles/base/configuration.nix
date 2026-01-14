{ lib, pkgs, systemSettings, ... }:

{
  imports = [
    ../../nyra/system
    ./cachix.nix
  ];

  # Kernel.
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

  networking.hostName = systemSettings.hostName;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nyramu = {
    isNormalUser = true;
    description = "Nyramu";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "jackaudio"
      "networkmanager"
    ];
    packages = with pkgs; [ neovim ];
  };

  # Login settings
  nyra.system.login.sddm.enable = true;

  # Default shell
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    git
    zip
    unzip
    curl
    util-linux
    zoxide
    usbutils
    kitty
  ];

  # Support MTP devices
  services.gvfs.enable = true;

  # Needed for gpu-screen-recorder
  security.wrappers.gsr-kms-server = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_admin+ep";
    source = "${pkgs.gpu-screen-recorder}/bin/gsr-kms-server";
    setuid = false;
    setgid = false;
  };


  # Support NTFS file system
  boot.supportedFilesystems = [ "ntfs" ];

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
  
    supportedLocales = [ 
      "it_IT.UTF-8/UTF-8" 
      "en_US.UTF-8/UTF-8" 
    ];
  
    extraLocaleSettings = {
      LC_TIME = "it_IT.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_MONETARY = "it_IT.UTF-8";
      LC_MEASUREMENT = "it_IT.UTF-8";
      LC_PAPER = "it_IT.UTF-8";
      LC_NAME = "it_IT.UTF-8";
      LC_ADDRESS = "it_IT.UTF-8";
      LC_TELEPHONE = "it_IT.UTF-8";
      LC_IDENTIFICATION = "it_IT.UTF-8"; 
    };
  };

  # CPU Frequency
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      energy_performance_preference = "performance";
      platform_profile = "performance";
      turbo = "auto";
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable bluetooth
  nyra.system.hardware.bluetooth.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true; 

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable uPower (battery service)
  services.upower.enable = true;

  # Storage optimization
  nix.settings.auto-optimise-store = true;

  # Allow unfree packages and experimental features
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "26.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" "pipe-operators" ];
}

