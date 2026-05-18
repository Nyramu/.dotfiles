{ self, ... }:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.localization ];

    localization =
      { localization, ... }:
      {
        console.keyMap = localization.keyboard.keyMap;
        services.xserver.xkb = {
          layout = localization.keyboard.layout;
          variant = localization.keyboard.variant;
        };

        time = {
          timeZone = localization.time.zone;
          hardwareClockInLocalTime = localization.time.hardware-clock.enable;
        };

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
      };
  };
}
