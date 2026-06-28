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
        config = {
          hyprnix.settings = lib.mkIf (cfg.desktops.hyprland.enable) rec {
            general = {
              col = {
                active_border = {
                  colors = [
                    "rgb(1a1210)"
                    "rgb(2a1e18)"
                    "rgb(ed6830)"
                    "rgb(ed6830)"
                    "rgb(e98c44)"
                  ];
                  angle = 220;
                };
                inactive_border = {
                  colors = [
                    "rgb(2a1c14)"
                    "rgb(3a2618)"
                  ];
                  angle = 220;
                };
              };
            };
            group = {
              col = {
                border_active = general.col.active_border;
                border_inactive = general.col.inactive_border;
                border_locked_active = {
                  colors = [
                    "rgb(1a1210)"
                    "rgb(c84018)"
                    "rgb(e13820)"
                  ];
                  angle = 220;
                };
                border_locked_inactive = general.col.inactive_border;
              };
              groupbar = {
                text_color = "rgb(ffc898)";
                text_color_inactive = "rgb(d88860)";
                text_color_locked_active = "rgb(ffc898)";
                text_color_locked_inactive = group.groupbar.text_color_inactive;
                col = {
                  active = "rgb(e98c44)";
                  inactive = "rgb(2a1c14)";
                  locked_active = "rgb(c84018)";
                  locked_inactive = group.groupbar.col.inactive;
                };
              };
            };
          };
          
          programs.noctalia-shell = lib.mkIf (cfg.desktops.layers.noctalia-shell.enable) {
            settings = {
              ui = {
                fontDefaultScale = 1.1;
                fontFixedScale = 1.1;
              };
              location = {
                analogClockInCalendar = false;
              };
            };
            colors = {
              mPrimary = lib.mkForce palette.base0C;
              mSecondary = lib.mkForce palette.base05;
            };
          };

          programs.vicinae = lib.mkIf (cfg.desktops.layers.vicinae.enable) {
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

          programs.kitty.settings = lib.mkIf (cfg.terminals.kitty.enable) {
            scrollbar_handle_color = lib.mkForce palette.base0D;
            cursor_trail_color = lib.mkForce palette.base09;
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
