{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  theme = import config.nyra.theme.path { inherit pkgs; };
  cfg = config.nyra.desktops.hyprland;
in
{
  imports = [
    inputs.hyprnix.homeModules.default
    ./binds.nix
    ./groups.nix
    ./animations.nix
    ./windowrules.nix
    ./plugins
  ];

  config = {
    stylix.targets.hyprland.colors.enable = false;
    hyprnix = {
      enable = cfg.enable;
      systemd.enable = true;
      xwayland.enable = true;
      settings = {
        monitors = cfg.monitors;

        render = {
          direct_scanout = 1;
          new_render_scheduling = true;
        };

        input = {
          kb_layout = "it";
          numlock_by_default = true;
          follow_mouse = 1;
          mouse_refocus = true;
          resolve_binds_by_sym = true;
          kb_options = "fkeys:basic_13-24";
        };

        cursor = {
          hyprcursor = {
            enable = true;
            package = pkgs.rose-pine-hyprcursor;
            name = "rose-pine-hyprcursor";
            size = 36;
          };
          inactive_timeout = 12;
          persistent_warps = true;
          warp_on_change_workspace = 0;
          hide_on_touch = true;
          hide_on_key_press = true;
        };

        binds = {
          workspace_center_on = 1;
        };

        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
        };

        workspaces = [
          {
            id = 1;
            rules.persistent = true;
          }
          {
            id = 2;
            rules.persistent = false;
          }
          {
            id = 3;
            rules.persistent = false;
          }
          {
            id = 4;
            rules.persistent = false;
          }
          {
            id = 5;
            rules.persistent = false;
          }
        ];

        general = {
          border_size = 2;
          resize_on_border = true;

          gaps_in = 5;
          gaps_out = 2;
          float_gaps = 2;

          col = {
            active_border = theme.hypr.active_border_color;
            inactive_border = theme.hypr.inactive_border_color;
          };

          layout = "dwindle";
          allow_tearing = false;

          snap = {
            enabled = true;
            respect_gaps = true;
          };
        };

        decoration = {
          rounding = 8;
          shadow = {
            range = 5;
            render_power = 3;
            color = "rgba(26, 26, 26, 0.93)";
          };
          screen_shader = lib.mkIf (cfg.shader.enable) cfg.shader.path;
          blur = {
            enabled = true;
            size = 1;
            passes = 2;
          };
          glow = {
            # enabled = true; # Somehow the option is broken on Hyprland
          };
        };

        dwindle.preserve_split = true;

        gesture = {
          # workspace_swipe_create_new = false;
          gestures = [
            {
              fingers = 3;
              direction = "pinch";
              action = {
                dispatcher = "fullscreen, maximize";
              };
            }
            {
              fingers = 3;
              direction = "vertical";
              action = "workspace";
            }
          ];
        };

        misc = {
          disable_hyprland_logo = true;
          force_default_wallpaper = 0;
          animate_manual_resizes = true;
          enable_swallow = true;
          swallow_regex = "^(${config.nyra.home.apps.defaultTerminal})$";
          session_lock_xray = true; # Should test with hyprlock or something
          animate_mouse_windowdragging = false; # Just lags for some reason
          vfr = false;
          vrr = 0;
        };
      };
    };
  };
}
