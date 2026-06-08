{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.modules.homeManager = {
    desktops.imports = [ self.modules.homeManager.noctalia ];

    noctalia =
      {
        config,
        performance,
        user,
        ...
      }:

      let
        msg = "noctalia msg";
        cfg = config.nyra.desktops.layers.noctalia;
      in
      {
        imports = [
          inputs.noctalia.homeModules.default
          self.modules.homeManager.hyprland
        ];

        options.nyra.desktops.layers.noctalia = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = "Enable noctalia-shell";
          };
        };

        config = lib.mkIf (cfg.enable) {
          programs.noctalia = {
            enable = true;
            systemd.enable = true;
            settings = {
              audio.enable_overdrive = true;
              bar = {
                default = {
                  background_opacity = 0.6;
                  center = [
                    "audio_visualizer"
                    "media"
                    "audio_visualizer"
                  ];
                  color = "primary";
                  contact_shadow = true;
                  end = [
                    "temp"
                    "volume"
                    "network"
                    "bluetooth"
                    "clock"
                  ];
                  font_weight = 400;
                  layer = "top";
                  margin_edge = 0;
                  margin_ends = 0;
                  padding = 20;
                  radius = 0;
                  scale = 1.3;
                  start = [
                    "battery"
                    "workspaces"
                    "tray"
                  ];
                  thickness = 48;
                  widget_spacing = 15;
                };
              };
              control_center = {
                shortcuts = [ ];
                sidebar = "none";
                sidebar_section = "none";
              };
              desktop_widgets.enabled = false;
              hooks = {
                started = "${msg} notification-dnd-set on; ${msg} notification-clear-history";
              };
              idle = {
                pre_action_fade_seconds = 0;
              };
              location = {
                address = "Sassari, Italy";
              };
              lockscreen = {
                blur_intensity = 0.25;
                blurred_desktop = true;
                tint_intensity = 0.25;
              };
              lockscreen_widgets = {
                enabled = true;
                grid = {
                  cell_size = 16;
                  major_interval = 4;
                  visible = false;
                };
                widget = {
                  "lockscreen-login-box@eDP-1" = {
                    box_height = 0;
                    box_width = 0;
                    cx = 960;
                    cy = 945;
                    output = "eDP-1";
                    rotation = 0;
                    type = "login_box";
                  };
                  lockscreen-widget-0000000000000001 = {
                    box_height = 175;
                    box_width = 690;
                    cx = 960;
                    cy = 280;
                    output = "eDP-1";
                    rotation = 0;
                    settings = {
                      background = false;
                      clock_style = "digital";
                      color = "primary";
                      font_family = "";
                      format = "{:%H:%M:%S}";
                    };
                    type = "clock";
                  };
                  lockscreen-widget-0000000000000002 = {
                    box_height = 110;
                    box_width = 320;
                    cx = 975;
                    cy = 160;
                    output = "eDP-1";
                    rotation = 0;
                    settings = {
                      background = false;
                      color = "secondary";
                    };
                    type = "weather";
                  };
                  lockscreen-widget-0000000000000003 = {
                    box_height = 0;
                    box_width = 0;
                    cx = 960;
                    cy = 382;
                    output = "eDP-1";
                    rotation = 0;
                    settings = {
                      background = false;
                      clock_style = "digital";
                      color = "tertiary";
                      format = "{:%D}";
                    };
                    type = "clock";
                  };
                  lockscreen-widget-0000000000000004 = {
                    box_height = 225;
                    box_width = 785;
                    cx = 960;
                    cy = 630;
                    output = "eDP-1";
                    rotation = 0;
                    settings = {
                      background = false;
                      fade_when_idle = true;
                      layout = "horizontal";
                    };
                    type = "media_player";
                  };
                };
                widget_order = [
                  "lockscreen-login-box@eDP-1"
                  "lockscreen-widget-0000000000000001"
                  "lockscreen-widget-0000000000000002"
                  "lockscreen-widget-0000000000000003"
                  "lockscreen-widget-0000000000000004"
                ];
              };
              notification = {
                layer = "overlay";
                position = "bottom_right";
              };
              osd = {
                background_opacity = 0.7;
                kinds = {
                  bluetooth = false;
                  brightness = false;
                  caffeine = false;
                  keyboard_layout = false;
                  power_profile = false;
                  volume_input = true;
                  wifi = false;
                };
                offset_y = 10;
                scale = 0.85;
              };
              shell = {
                animation = {
                  speed = 0.9;
                };
                avatar_path = user.pfp;
                clipboard_enabled = false;
                corner_radius_scale = 0.9;
                launch_apps_as_systemd_services = true;
                mpris.blacklist = [
                  "zen-twilight"
                  "telegram"
                ];
                panel = {
                  open_near_click_control_center = true;
                  open_near_click_session = true;
                  session_placement = "floating";
                  transparency_mode = "soft";
                };
                screenshot = {
                  copy_to_clipboard = false;
                  freeze_screen = false;
                  save_to_file = false;
                };
                session = {
                  actions = [
                    {
                      action = "lock";
                      enabled = true;
                      shortcut = "1";
                      variant = "default";
                    }
                    {
                      action = "logout";
                      enabled = true;
                      shortcut = "2";
                      variant = "default";
                    }
                    {
                      action = "reboot";
                      enabled = true;
                      shortcut = "4";
                      variant = "default";
                    }
                    {
                      action = "shutdown";
                      enabled = true;
                      shortcut = "5";
                      variant = "destructive";
                    }
                  ];
                };
                settings_show_advanced = true;
                shadow = {
                  alpha = 1;
                };
                telemetry_enabled = true;
                time_format = "{:%H:%M}";
                ui_scale = 1.15;
              };
              system = {
                monitor = {
                  cpu_poll_seconds = 1;
                  cpu_temp_critical_threshold = 80;
                  gpu_poll_seconds = 1;
                  gpu_temp_critical_threshold = 80;
                  memory_poll_seconds = 1;
                };
              };
              templates = { };
              theme = {
                custom_palette = "stylix";
                source = "custom";
                templates = {
                  enable_builtin_templates = false;
                  enable_community_templates = false;
                };
              };
              wallpaper = {
                enabled = true;
                default.path = config.stylix.image;
                directory = user.dotfiles + "/modules/themes";
                edge_smoothness = 0;
                transition = [ "honeycomb" ];
              };
              wallpaper_panel = {
                flatten = true;
              };
              widget = {
                audio_visualizer = {
                  bands = 24;
                  high_color = "on_surface";
                  scale = 1.8;
                  width = 45;
                };
                battery = {
                  color = "on_surface";
                };
                clock = {
                  anchor = true;
                  color = "error";
                  format = "{:%H:%M:%S}";
                };
                media = {
                  anchor = true;
                  art_size = 25;
                  color = "on_surface";
                  hide_when_no_media = true;
                  max_length = 400;
                  title_scroll = "on_hover";
                };
                temp = {
                  display = "text";
                };
                tray = {
                  color = "secondary";
                  pinned = [
                    "steam"
                    "telegram"
                    "spotify"
                  ];
                };
                workspaces = {
                  capsule_radius = 7;
                  hide_when_empty = true;
                  scale = 1.1;
                };
              };
            };
          };

          stylix.targets.hyprland.hyprpaper.enable = false;

          hyprnix.settings.layer_rule = lib.mkIf (config.nyra.desktops.hyprland.enable) {
            "noctalia-blur" = {
              blur = true;
              blur_popups = true;
              ignore_alpha = 0.5;
              match.namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd)$";
            };
          };
        };
      };
  };
}
