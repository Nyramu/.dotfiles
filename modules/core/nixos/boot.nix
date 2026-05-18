{ self, ... }:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.boot ];

    boot = {
      boot = {
        initrd = {
          systemd.enable = true;
          systemd.emergencyAccess = true;
        };

        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };

        supportedFilesystems = [ "ntfs" ];
      };
    };
  };
}
