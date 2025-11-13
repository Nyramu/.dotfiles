{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.system.hardware.bluetooth;
in
{
  options.nyra.system.hardware.bluetooth = {
    enable = mkEnableOption "bluetooth";
  };

  config = {
    hardware.bluetooth = {
      enable = cfg.enable;
      powerOnBoot = cfg.enable;
      settings.General = {
        Experimental = true;
        FastConnectable = true;
      };
    };

    services.blueman.enable = mkDefault cfg.enable;

    environment.systemPackages = with pkgs; optionals cfg.enable [
      bluez
      blueman
      bluetuith
    ];
  };
}
