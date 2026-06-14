{ self, lib, ... }:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.boot ];

    boot =
      { pkgs, boot, ... }:

      {
        boot = {
          initrd = {
            systemd.enable = true;
            systemd.emergencyAccess = true;
            verbose = !boot.silent;
          };

          loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
          };
          supportedFilesystems = [ "ntfs" ];

          kernelParams =
            lib.optionals (boot.silent) [
              "quiet"
              "udev.log_level=3"
            ]
            ++ lib.optionals (boot.splash != null) [ "plymouth.use-simpledrm" ];

          consoleLogLevel = lib.mkIf (boot.silent) 0;

          plymouth = lib.mkIf (boot.splash != null) {
            enable = true;
            theme = boot.splash;
            themePackages = [
              (pkgs.adi1090x-plymouth-themes.override {
                selected_themes = [
                  boot.splash
                  # "lone"
                  # "connect"
                  # "dna"
                ];
              })
            ];
          };
        };

        stylix.targets.plymouth.enable = (boot.splash == null);
      };
  };
}
