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
                active_border = "rgb(${rawHex palette.base02}) rgb(${rawHex palette.base03}) rgb(${rawHex palette.base0A}) rgb(${rawHex palette.base08}) 270deg";
                inactive_border = "rgb(152927)";
              };
            };

            group = {
              col = {
                border_active = general.col.active_border;
                border_inactive = general.col.inactive_border;
                border_locked_active = "rgb(13160d) rgb(274044) rgb(${rawHex palette.base0D}) 270deg";
                border_locked_inactive = general.col.inactive_border;
              };

              groupbar = {
                text_color = "rgb(${rawHex palette.base0C})";
                text_color_inactive = "rgb(909090)";
                text_color_locked_active = "rgb(b9f9e1)";
                text_color_locked_inactive = group.groupbar.text_color_inactive;

                col = {
                  active = "rgb(${rawHex palette.base08})";
                  inactive = general.col.inactive_border;
                  locked_active = "rgb(90b7b2)";
                  locked_inactive = group.groupbar.col.inactive;
                };
              };
            };
          };

          programs.noctalia-shell = lib.mkIf (cfg.desktops.layers.noctalia.enable) {
            settings = {
              ui = {
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
