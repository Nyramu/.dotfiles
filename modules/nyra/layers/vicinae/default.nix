{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.modules.homeManager = {
    layers.imports = [ self.modules.homeManager.vicinae ];

    vicinae =
      { config, ... }:

      let
        cfg = config.nyra.layers.vicinae;
      in
      {
        imports = [
          inputs.vicinae.homeManagerModules.default
        ];

        options.nyra.layers.vicinae = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = "Enable vicinae";
          };
        };

        config = lib.mkIf (cfg.enable) {
          programs.vicinae = {
            enable = true;
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
              favorites = [
                "@fbosch/vicinae-extension-protondb-search-0:protondb-search"
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

          hyprnix.settings = lib.mkIf (config.nyra.desktops.hyprland.enable) {
            bind = {
              # Restart Vicinae
              "SUPER + SHIFT + SPACE".dispatcher.exec_cmd = "systemctl --user restart vicinae.service";
              # Toggle spawn
              "SUPER + SPACE".dispatcher.exec_cmd = "vicinae toggle";
              # Access clipboard
              "SUPER + C".dispatcher.exec_cmd = "vicinae vicinae://launch/clipboard/history";
            };

            layer_rule = {
              "vicinae-blur" = {
                blur = true;
                ignore_alpha = 0;
                match.namespace = "vicinae";
              };
            };
          };
        };
      };
  };

  flake.modules.nixos = {
    layers.imports = [ self.modules.nixos.vicinae ];

    vicinae =
      { config, host, ... }:

      let
        cfg = config.nyra.layers.vicinae;
      in
      {
        options.nyra.layers.vicinae = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = "Enable vicinae";
          };
        };

        config = lib.mkIf (cfg.enable) {
          # Implement Vicinae nixosModule directly to permit management
          # via nyra options
          security.wrappers.vicinae-input-server = {
            source = "${inputs.vicinae.packages.${host.system}.default}/libexec/vicinae/vicinae-input-server";
            capabilities = "cap_dac_override+ep";
            owner = "root";
            group = "root";
          };
        };
      };
  };
}
