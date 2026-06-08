{ self, lib, ... }:
{
  flake.modules.homeManager = {
    theme-lanterns =
      { config, ... }:

      let
        cfg = config.nyra;
        palette = config.stylix.base16Scheme;
        rawHex = lib.removePrefix "#";
      in
      {
        imports = with self.modules.homeManager; [
          desktops
          kitty
        ];

        config = {
          hyprnix.settings = lib.mkIf (cfg.desktops.hyprland.enable) rec {
            general = {
              col = {
                active_border = {
                  colors = [
                    "rgb(${rawHex palette.base02})"
                    "rgb(${rawHex palette.base0E})"
                    "rgb(${rawHex palette.base0B})"
                    "rgb(e8708a)"
                  ];
                  angle = 270;
                };
                inactive_border = "rgb(${rawHex palette.base02})";
              };
            };

            group = {
              col = {
                border_active = general.col.active_border;
                border_inactive = general.col.inactive_border;
                border_locked_active = {
                  colors = [
                    "rgb(${rawHex palette.base02})"
                    "rgb(${rawHex palette.base0F})"
                    "rgb(${rawHex palette.base08})"
                    "rgb(${rawHex palette.base08})"
                    "rgb(${rawHex palette.base09})"
                  ];
                  angle = 270;
                };
                border_locked_inactive = general.col.inactive_border;
              };

              groupbar = {
                text_color = "rgb(e8708a)";
                text_color_inactive = "rgb(909090)";
                text_color_locked_active = "rgb(${rawHex palette.base09})";
                text_color_locked_inactive = group.groupbar.text_color_inactive;

                col = {
                  active = "rgb(e8708a)";
                  inactive = general.col.inactive_border;
                  locked_active = "rgb(${rawHex palette.base09})";
                  locked_inactive = group.groupbar.col.inactive;
                };
              };
            };
          };

          programs.noctalia-shell = lib.mkIf (cfg.desktops.layers.noctalia-shell.enable) {
            settings = {
              ui = {
                panelBackgroundOpacity = lib.mkForce 0.6;
                fontDefaultScale = 1.15;
                fontFixedScale = 1.15;
              };
              location = {
                analogClockInCalendar = false;
              };
            };
            colors = {
              mPrimary = lib.mkForce palette.base0E;
              mSecondary = lib.mkForce palette.base0D;
            };
          };

          programs.kitty.settings = lib.mkIf (cfg.terminals.kitty.enable) {
            scrollbar_handle_color = lib.mkForce palette.base08;
            cursor_trail_color = lib.mkForce palette.base0B;
          };
        };
      };
  };

  flake.modules.nixos = {
    theme-lanterns =
      { config, ... }:

      let
        cfg = config.nyra;

      in
      {
        imports = with self.modules.nixos; [
        ];

        config = {

        };
      };
  };
}
