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
    useDongle = lib.mkEnableOption "use external USB Bluetooth dongle (disables internal Bluetooth)";
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

    # Must be tested
    services.udev.extraRules = lib.mkIf (cfg.enable && cfg.useDongle) ''
      ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0bda", ATTR{idProduct}=="886c", ATTR{authorized}="0"
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
