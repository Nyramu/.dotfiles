{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.system.bluetooth;
in
{
  options.nyra.system.bluetooth = {
    enable = mkEnableOption "bluetooth";
  };

  config = {
    hardware.bluetooth = {
      enable = cfg.enable;
      powerOnBoot = cfg.enable;
    };

    services.blueman.enable = mkDefault cfg.enable;

    environment.systemPackages = with pkgs; optionals cfg.enable [ bluez blueman bluetuith ];
  };
}
