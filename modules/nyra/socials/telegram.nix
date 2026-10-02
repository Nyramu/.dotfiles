{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.modules.homeManager = {
    socials.imports = [ self.modules.homeManager.telegram ];

    telegram =
      {
        config,
        pkgs,
        host,
        ...
      }:

      let
        cfg = config.nyra.socials.telegram;
        telegram =
          if (cfg.unstable) then
            inputs.chaotic.packages.${host.system}.telegram-desktop-unwrapped_git
          else
            pkgs.telegram-desktop;
      in
      {
        options.nyra.socials.telegram = {
          enable = lib.mkEnableOption "Telegram Desktop";
          unstable = lib.mkEnableOption "" // {
            description = "Use Telegram git version";
          };
        };

        config = lib.mkIf (cfg.enable) {
          home.packages = [ telegram ];

          hyprnix.settings.bind = lib.mkIf (config.nyra.desktops.hyprland.enable) {
            "SUPER + T".dispatcher.exec_cmd = "Telegram";
          };
        };
      };
  };
}
