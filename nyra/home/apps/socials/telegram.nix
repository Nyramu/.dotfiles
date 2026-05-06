{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nyra.apps.socials.telegram;
in
{
  options.nyra.apps.socials = {
    telegram.enable = lib.mkEnableOption "telegram";
  };

  config = lib.mkIf (cfg.enable) {
    home.packages = with pkgs; [
      telegram-desktop
    ];
  };
}
