{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nyra.system.bluetooth;
in
{
  options.nyra.system.bluetooth = {
    enable = lib.mkEnableOption "bluetooth";
    onlyUseDongle = lib.mkEnableOption "disables internal Bluetooth forcing to use an external controller";
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

    systemd.services.bluetooth.serviceConfig = lib.mkIf cfg.enable {
      Nice = -15;
    };

    services.blueman.enable = lib.mkDefault cfg.enable;

    services.udev.extraRules = lib.mkIf (cfg.enable && cfg.onlyUseDongle) ''
      ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="0bda", ATTR{authorized}="0"
    '';

    environment.systemPackages =
      with pkgs;
      lib.optionals cfg.enable [
        bluez
        blueman
        bluetuith
      ];
  };
}
