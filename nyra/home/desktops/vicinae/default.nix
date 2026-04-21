{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

let
  theme = import config.nyra.theme.path { inherit pkgs; };
  cfg = config.nyra.desktops;
in
{
  imports = [
    inputs.vicinae.homeManagerModules.default
    ./providers.nix
    ./extensions.nix
  ];

  services.vicinae = {
    enable = cfg.hyprland.enable;
    systemd.enable = true;
    settings = {
      close_on_focus_loss = false;
      consider_preedit = false;
      pop_to_root_on_close = true;
      favicon_service = "twenty";
      search_files_in_root = true;
      escape_key_behavior = "navigate_back";
      launcher_window = {
        opacity = lib.mkIf (theme ? vicinae.ui.opacity) (lib.mkForce theme.vicinae.ui.opacity);
        layer_shell = {
          enabled = true;
          keyboard_interactivity = "on_demand";
          layer = "top";
        };
        size = {
          width = 900;
          height = 561;
        };
        client_side_decorations.enabled = true;
      };
      font = {
        normal = {
          size = theme.vicinae.font.normal.size or 10.5;
          family = "${theme.fonts.serif.name}";
        };
      };
      favorites = [
        "@Gimblet/vicinae-extension-noctalia-shell-wallpaper-selector-0:change-your-wallpaper"
        "@sovereign/vicinae-extension-hypr-keybinds-0:hyprland-keybinds"
        "@leonkohli/vicinae-extension-process-manager-0:processes"
        "@Costeer/vicinae-extension-color-converter-0:convert-color"
      ];
      keybinds = {
        "toggle-action-panel" = "control+return";
        "action.duplicate" = "control+t";
        "action.dangerous-remove" = "control+shift+d";
        "action.remove" = "control+d";
      };
      fallbacks = [ ];
    };
  };
}
