{ self, lib, ... }:
{
  flake.modules.homeManager = {
    desktops.imports = [ self.modules.homeManager.wayle ];

    wayle =
      { config, ... }:

      let
        cfg = config.nyra.desktops.layers.wayle;
      in
      {
        options.nyra.desktops.layers.wayle = {
          enable = lib.mkEnableOption "Enable wayle";
        };

        config = lib.mkIf (cfg.enable) {
          services.wayle = {
            enable = true;

            # nix-instantiate --eval --expr 'builtins.fromTOML (builtins.readFile ./runtime.toml)' | nixfmt
            settings = {
              bar = {
                scale = 0.85;
                padding = 0.35;
                padding-ends = 1;
                module-gap = 1;
                location = "top";
                exclusive = true;
                layer = "overlay";
                bg = "bg-surface";
                background-opacity = 65;
                button-bg-opacity = 0;
                button-icon-size = 0.9;
                button-label-size = 1.15;
                button-label-weight = "medium";
                button-variant = "basic";
                dropdown-freeze-label = false;
                layout = [
                  {
                    center = [
                      "dashboard"
                      "media"
                    ];
                    left = [
                      "battery"
                      "hyprland-workspaces"
                      "systray"
                    ];
                    monitor = "*";
                    right = [
                      "cpu"
                      "volume"
                      "network"
                      "bluetooth"
                      "clock"
                    ];
                    show = true;
                  }
                ];
                shadow = "drop";
              };
              general = {
                font-mono = "CodeNewRoman Nerd Font Mono";
                font-sans = "CodeNewRoman Nerd Font";
                tearing-mode = true;
              };
              modules = {
                clock = {
                  format = "%H:%M:%S";
                  dropdown-show-seconds = true;
                };
                cpu = {
                  format = "{{ temp_c }}°C";
                  poll-interval-ms = 1000;
                };
                hyprland-workspaces = {
                  app-icons-show = true;
                };
                notifications = {
                  popup-position = "bottom-left";
                };
                weather = {
                  time-format = "24h";
                };
              };
              osd = {
                duration = 600;
                margin = 100;
                position = "top";
              };
              wallpaper = {
                engine-enabled = false;
              };
            };
          };
        };
      };
  };
}
