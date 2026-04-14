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

  config.hyprnix = {
    enable = cfg.enable;
    systemd.enable = true;
    xwayland.enable = true;
    settings = {
      permissions = [
        {
          executable = "${lib.getExe pkgs.grim}";
          permission = "screencopy";
          mode = "deny";
        }
      ];

      monitors = [
        {
          output = "eDP-1";
          mode = "1920x1200@60";
          position = "auto";
          scale = 1;
        }
      ];

      render.direct_scanout = 1;

      misc = {
        vfr = false;
        vrr = 0;
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
        inactive_timeout = 0;
        warp_on_change_workspace = 0;
        hide_on_touch = false;
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
          rules.persistent = true;
        }
        {
          id = 5;
          rules.persistent = true;
        }
      ];

      general = {
        border_size = 2;
        resize_on_border = true;

        gaps_in = 5;
        gaps_out = 2;

        # active_border_color = theme.hypr.active_border_color;
        # inactive_border_color = theme.hypr.inactive_border_color;

        layout = "dwindle";
        allow_tearing = false;
      };

      decoration = {
        rounding = 8;
        shadow = {
          range = 5;
          render_power = 3;
          # color = "rgba(26, 26, 26, 0.93)";
        };
        screen_shader = lib.mkIf (cfg.shader.enable) "shader.frag";
        blur.enabled = false;
      };

      # Gives more freedom in windows management compared to Master
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master.new_status = "master";

      gesture = {
        gestures = [
          {
            fingers = 3;
            direction = "pinch";
            action = "fullscreen";
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
        animate_mouse_windowdragging = false; # Just lags for some reason
      };

      # env = {
      #   HYPRCURSOR_THEME = "rose-pine-hyprcursor";
      #   HYPRCURSOR_SIZE = 36;
      # };
    };
  };
  # config.home.packages = with pkgs; [ rose-pine-hyprcursor ];
  config.xdg.configFile."hypr/shader.frag".source = cfg.shader.path;
}
