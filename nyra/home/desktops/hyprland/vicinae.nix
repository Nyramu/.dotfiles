{
  config,
  inputs,
  pkgs,
  ...
}: let
  cfgHyprland = config.nyra.home.desktops.hyprland;
  themeName = config.nyra.theme.defaultTheme;
  theme = import ../../../../resources/themes/${themeName}.nix {inherit pkgs;};
in {
  imports = [inputs.vicinae.homeManagerModules.default];

  services.vicinae = {
    enable = cfgHyprland.enable;
    systemd = {
      enable = true;
      autoStart = true; # default: false
      environment = {
        USE_LAYER_SHELL = 1;
      };
    };
    settings = {
      close_on_focus_loss = true;
      consider_preedit = true;
      pop_to_root_on_close = true;
      favicon_service = "twenty";
      search_files_in_root = true;

      font = theme.vicinae.font;
    };
    extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
      bluetooth
    ];
  };
}
