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
                active_border = {
                  colors = [
                    "rgb(1a1625)"
                    "rgb(b83858)"
                    "rgb(983050)"
                  ];
                  angle = 330;
                };
                inactive_border = {
                  colors = [
                    "rgb(1a1625)"
                  ];
                };
              };
            };
            group = {
              col = {
                border_active = general.col.active_border;
                border_inactive = general.col.inactive_border;
                border_locked_active = {
                  colors = [
                    "rgb(1a1625)"
                    "rgb(5f1d25)"
                    "rgb(ccb0ad)"
                  ];
                  angle = 270;
                };
                border_locked_inactive = general.col.inactive_border;
              };
              groupbar = {
                text_color = "rgb(faeaf0)";
                text_color_inactive = "rgb(5a4560)";
                text_color_locked_active = "rgb(faeaf0)";
                text_color_locked_inactive = group.groupbar.text_color_inactive;
                col = {
                  active = {
                    colors = [
                      "rgb(983050)"
                    ];
                  };
                  inactive = {
                    colors = [
                      "rgb(1a1625)"
                    ];
                  };
                  locked_active = {
                    colors = [
                      "rgb(ccb0ad)"
                    ];
                  };
                  locked_inactive = group.groupbar.col.inactive;
                };
              };
            };
          };

          programs.noctalia-shell = lib.mkIf (cfg.desktops.layers.noctalia-shell.enable) {
            colors = {
              mPrimary = lib.mkForce palette.base0A;
              mSecondary = lib.mkForce palette.base07;
              mTertiary = lib.mkForce palette.base03;
              mOutline = lib.mkForce palette.base02;
              mHover = lib.mkForce palette.base02;
              mOnHover = lib.mkForce palette.base0A;
            };
          };

          programs.vicinae = lib.mkIf (cfg.desktops.layers.vicinae.enable) {
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
