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
          inputs.chaotic.packages.${host.system}.telegram-desktop-unwrapped_git or pkgs.telegram-desktop;
      in
      {
        options.nyra.socials.telegram = {
          enable = lib.mkEnableOption "telegram";
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
