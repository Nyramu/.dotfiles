{ self, lib, ... }:
{
  flake.modules.homeManager = {
    theme-pixel-sunset =
      { config, ... }:

      let
        cfg = config.nyra;
        palette = config.stylix.base16Scheme;
      in
      {
        imports = with self.modules.homeManager; [
          desktops
          kitty
        ];

        config = {
          # hyprnix.settings = lib.mkIf (cfg.desktops.hyprland.enable) rec {
          #   general = {
          #     col = {
          #       active_border = "rgb(542624) rgb(d66e65) rgb(fa696e) 270deg";
          #       inactive_border = "rgb(152927)";
          #     };
          #   };

          #   group = {
          #     col = {
          #       border_active = general.col.active_border;
          #       border_inactive = general.col.inactive_border;
          #       # Picked from wallpaper
          #       border_locked_active = "rgb(13160d) rgb(274044) rgb(90b7b2) 270deg";
          #       border_locked_inactive = general.col.inactive_border;
          #     };

          #     groupbar = {
          #       text_color = "rgb(ffb0b4)"; # palette.base07
          #       text_color_inactive = "rgb(909090)"; # palette.base04
          #       text_color_locked_active = "rgb(b9f9e1)"; # Picked from wallpaper, lighter than locked active border
          #       text_color_locked_inactive = group.groupbar.text_color_inactive;

          #       col = {
          #         active = "rgb(fa696e)"; # Last color from active border
          #         inactive = "rgb(152927)"; # Color from inactive border
          #         locked_active = "rgb(90b7b2)"; # Last color from locked active border
          #         locked_inactive = group.groupbar.col.inactive;
          #       };
          #     };
          #   };
          # };

          programs.noctalia-shell = lib.mkIf (cfg.desktops.layers.noctalia.enable) {
            colors = {
              mPrimary = lib.mkForce palette.base0A;
              mSecondary = lib.mkForce palette.base07;
              mTertiary = lib.mkForce palette.base03;
              mOutline = lib.mkForce palette.base02;
              mHover = lib.mkForce palette.base02;
              mOnHover = lib.mkForce palette.base0A;
            };
          };

          services.vicinae = lib.mkIf (cfg.desktops.layers.vicinae.enable) {
            settings = {
              launcher_window = {
                opacity = lib.mkForce 0.9;
              };
            };
          };
        };
      };
  };

  flake.modules.nixos = {
    theme-pixel-sunset =
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
