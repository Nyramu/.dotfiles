{ self, lib, ... }:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.bluetooth ];

    bluetooth =
      {
        bluetooth,
        pkgs,
        ...
      }:
      {
        hardware.bluetooth = lib.mkIf (bluetooth.enable) {
          enable = true;
          powerOnBoot = true;
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

        boot.kernelParams = [
          "btusb.enable_autosuspend=0"
          "iwlwifi.bt_coex_active=0"
        ];

        systemd.services.bluetooth.serviceConfig = {
          Nice = -17;
        };

        services.blueman.enable = lib.mkDefault true;

        services.udev.extraRules = lib.mkIf (bluetooth.useDongleOnly) ''
          ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="0bda", ATTR{authorized}="0"
        '';

        environment.systemPackages = with pkgs; [
          bluez
          blueman
          bluetuith
        ];
      };
  };
}
