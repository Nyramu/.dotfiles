{ self, lib, ... }:
{
  flake.modules.homeManager = {
    theme-apocalypse =
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
          hyprnix.settings = lib.mkIf (cfg.desktops.hyprland.enable) rec {
            general = {
              col = {
                active_border = "rgb(1a1210) rgb(2a1e18) rgb(ed6830) rgb(ed6830) rgb(e98c44) 220deg";
                inactive_border = "rgb(2a1c14) rgb(3a2618) 220deg";
              };
            };

            group = {
              col = {
                border_active = general.col.active_border;
                border_inactive = general.col.inactive_border;
                # Picked from wallpaper
                border_locked_active = "rgb(1a1210) rgb(c84018) rgb(e13820) 220deg";
                border_locked_inactive = general.col.inactive_border;
              };
              groupbar = {
                text_color = "rgb(ffc898)"; # palette.base07
                text_color_inactive = "rgb(d88860)"; # palette.base04
                text_color_locked_active = "rgb(ffc898)"; # Picked from wallpaper, lighter than locked active border
                text_color_locked_inactive = group.groupbar.text_color_inactive;
                col = {
                  active = "rgb(e98c44)"; # Last color from active border
                  inactive = "rgb(2a1c14)"; # Color from inactive border
                  locked_active = "rgb(c84018)"; # Last color from locked active border
                  locked_inactive = group.groupbar.col.inactive;
                };
              };
            };
          };

          programs.noctalia-shell = lib.mkIf (cfg.desktops.layers.noctalia.enable) {
            settings = {
              ui = {
                fontDefaultScale = 1.25;
                fontFixedScale = 1.25;
              };
              location = {
                analogClockInCalendar = false;
              };
            };
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
                  size = 13.5;
                };
              };
              launcher_window = {
                opacity = lib.mkForce 0.83;
              };
            };
          };
        };
      };
  };

  flake.modules.nixos = {
    theme-apocalypse =
      { config, ... }:

      let
        cfg = config.nyra;
      in
      {
        imports = with self.modules.nixos; [
          login
        ];

        config = {
          # programs.silentSDDM = lib.mkIf (cfg.login.silentSddm.enable) {
          #   settings = {
          #     "LoginScreen.LoginArea.Avatar" = {
          #       shape = lib.mkForce "circle";
          #     };
          #   };
          # };
        };
      };
  };
}
