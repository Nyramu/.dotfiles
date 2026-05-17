{ self, lib, ... }:
{
  flake.modules.homeManager = {
    theme-red-eclipse =
      { config, ... }:

      let
        cfg = config.nyra;
        palette = config.stylix.base16Scheme;
      in
      {
        imports = with self.modules.homeManager; [
          desktops
        ];

        config = {
          hyprnix.settings = lib.mkIf (cfg.desktops.hyprland.enable) rec {
            general = {
              col = {
                active_border = "rgb(1a1625) rgb(b83858) rgb(983050) 330deg";
                inactive_border = "rgb(1a1625)";
              };
            };

            group = {
              col = {
                border_active = general.col.active_border;
                border_inactive = general.col.inactive_border;
                # Picked from wallpaper
                border_locked_active = "rgb(1a1625) rgb(5f1d25) rgb(ccb0ad) 270deg";
                border_locked_inactive = general.col.inactive_border;
              };
              groupbar = {
                text_color = "rgb(faeaf0)"; # palette.base07
                text_color_inactive = "rgb(5a4560)"; # palette.base04
                text_color_locked_active = "rgb(faeaf0)"; # Picked from wallpaper, lighter than locked active border
                text_color_locked_inactive = group.groupbar.text_color_inactive;
                col = {
                  active = "rgb(983050)"; # Last color from active border
                  inactive = "rgb(1a1625)"; # Color from inactive border
                  locked_active = "rgb(ccb0ad)"; # Last color from locked active border
                  locked_inactive = group.groupbar.col.inactive;
                };
              };
            };
          };

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
              font = {
                normal = {
                  size = 12;
                };
              };
            };
          };
        };
      };
  };

  flake.modules.nixos = {
    theme-red-eclipse =
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
