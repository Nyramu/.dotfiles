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
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
        KernelExperimental = true;
        ControllerMode = "dual";
        FastConnectable = true;
        Privacy = "device";
      };
      settings.Policy = {
        AutoEnable = true;
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
