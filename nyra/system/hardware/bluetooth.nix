{ config, lib, pkgs, ... }:

let
  cfg = config.nyra.system.bluetooth;
in
{
  options.nyra.system.bluetooth = {
    enable = lib.mkEnableOption "bluetooth";
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

    services.blueman.enable = lib.mkDefault cfg.enable;

    environment.systemPackages = with pkgs; lib.optionals cfg.enable [
      bluez
      blueman
      bluetuith
    ];
  };
}
