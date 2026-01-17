{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.nyra.home.desktops;
  themeName = config.nyra.theme.defaultTheme;
  theme = import ../../../../resources/themes/${themeName}.nix {inherit pkgs;};
in {
  imports = [inputs.vicinae.homeManagerModules.default];

  services.vicinae = {
    enable = cfg.hyprland.enable;
    systemd = {
      enable = true;
      autoStart = true; # default: false
      environment = {
        USE_LAYER_SHELL = 1;
      };
    };
    settings = {
      close_on_focus_loss = false;
      consider_preedit = true;
      pop_to_root_on_close = true;
      favicon_service = "twenty";
      search_files_in_root = true;
      font = {
        normal = {
          size = theme.vicinae.font.normal.size or 10.5;
          normal = lib.mkIf (theme ? vicinae.font.normal.normal) theme.vicinae.font.normal.normal;
        };
      };
      launcher_window.opacity = lib.mkIf (theme ? vicinae.ui.opacity) (lib.mkForce theme.vicinae.ui.opacity);
    };
    extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
      aria2-manager
      nix
    ];
  };
}
