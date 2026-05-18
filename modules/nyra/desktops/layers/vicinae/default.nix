{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.modules.homeManager = {
    desktops.imports = [ self.modules.homeManager.vicinae ];

    vicinae =
      { config, ... }:

      let
        cfg = config.nyra.desktops.layers.vicinae;
      in
      {
        imports = [ inputs.vicinae.homeManagerModules.default ];

        options.nyra.desktops.layers.vicinae = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = "Enable vicinae";
          };
        };

        config = lib.mkIf (cfg.enable) {
          services.vicinae = {
            enable = cfg.enable;
            systemd.enable = true;
            settings = {
              close_on_focus_loss = false;
              consider_preedit = false;
              pop_to_root_on_close = true;
              favicon_service = "twenty";
              search_files_in_root = true;
              escape_key_behavior = "navigate_back";
              launcher_window = {
                layer_shell = {
                  enabled = true;
                  keyboard_interactivity = "exclusive";
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
                  size = lib.mkDefault 10.5;
                  family = "${config.stylix.fonts.serif.name}";
                };
              };
              favorites = [
                "@Gimblet/vicinae-extension-noctalia-shell-wallpaper-selector-0:change-your-wallpaper"
                "@fbosch/vicinae-extension-protondb-search-0:protondb-search"
                "@sovereign/vicinae-extension-hypr-keybinds-0:hyprland-keybinds"
                "@leonkohli/vicinae-extension-process-manager-0:processes"
                # "@Costeer/vicinae-extension-color-converter-0:convert-color"
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
        };
      };
  };
}
