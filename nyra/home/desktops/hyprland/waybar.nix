{ config, lib, pkgs, ... }: with lib; 

let
  # TODO: Improve these variables
  cfg = config.nyra.home;
  cfgHyprland = cfg.desktops.hyprland; 
  themeName = config.nyra.theme.defaultTheme;
  theme = import ../../../../resources/themes/${themeName}.nix { inherit pkgs; };
  stylix-fonts = config.stylix.fonts;
  stylix-palette = config.stylix.base16Scheme;
in
{
  home.packages = with pkgs; optionals cfgHyprland.enable [
    networkmanagerapplet
  ];
  programs.waybar = {
    enable = cfgHyprland.enable;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 50;
        spacing = 3;
        exclusive = true;
        gtk-layer-shell = true;
        passthrough = false;
        fixed-center = true;

        modules-left = [
          "battery"
          "hyprland/workspaces"
          "tray"
        ];
        modules-center = [
          "mpd"
        ];
        modules-right = [
          "pulseaudio"
          "pulseaudio#microphone"
          "network"
          "bluetooth"
          "clock"
        ];

        "hyprland/workspaces" = {
          format = "{id}";
          on-click = "activate";
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
          all-outputs = true;
          disable-scroll = false;
          active-only = false;
        };

        mpd = mkIf cfg.apps.media.music.enable {
          format = "{randomIcon} {repeatIcon}<span color='${stylix-palette.base0A}'>|</span> {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ({songPosition}/{queueLength}) <span color='${stylix-palette.base0A}'>|</span> {singleIcon} {consumeIcon}";
          format-disconnected = "MPD Disconnected ";
          format-stopped = " RMPC Stopped";
          random-icons = {
            off= "<span color='${stylix-palette.base04}'>  </span>";
            on = "  ";
          };
          repeat-icons = {
            off= "<span color='${stylix-palette.base04}'> </span>";
            on = " ";
          };
          single-icons = {
            off= "<span color='${stylix-palette.base04}'>󰼏 </span>";
            on = "󰼏 ";
          };
          consume-icons = {
            off= "<span color='${stylix-palette.base04}'>  </span>";
            on = "  ";
          };
          state-icons = {
            paused = " ";
            playing = "❚❚ ";
          };
          on-click = "rmpc togglepause";
          on-click-middle = "rmpc stop";
          on-click-right = "${getExe pkgs.${cfg.apps.terminals.default}} -e ${getExe pkgs.rmpc}";
          on-scroll-up = "rmpc prev";
          on-scroll-down = "rmpc next";
          tooltip = false;
          #interval = 1;
        };

        cava = {};

        cpu = {
          interval = 3;
          format = "<span color='${theme.waybar.glyph-color}'>  </span><span color='${stylix-palette.base05}'>{usage}%</span> <span color='${theme.waybar.glyph-color}'>|</span> <span color='${stylix-palette.base05}'>{avg_frequency} GHz</span>";
          tooltip = false;
        };

        memory = {
          interval = 3;
          format = "<span color='${theme.waybar.glyph-color}'>  </span><span color='${stylix-palette.base05}'>{percentage}%</span> <span color='${stylix-palette.base0A}'>|</span> <span color='${stylix-palette.base05}'>{used:0.1f} GB/{total:0.1f} GB</span>";
          tooltip = false; # TODO: decide to put or not btop 'quick launch'
        };

        pulseaudio = {
          format = "<span color='${theme.waybar.glyph-color}'>{icon}</span><span color='${stylix-palette.base05}'>{volume}%</span>";
          format-muted = "<span color='${stylix-palette.base04}'>󰖁 Muted</span>";
          format-icons = {
            default = [" " " " " "];
            headphone = " ";
            headset = " ";
            portable = "";
            speaker = "󰓃 ";
            hdmi = "󰡁 ";
            car = "";
          };
          scroll-step = 5;
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol -t 3";
          on-click-right = "${pkgs.pamixer}/bin/pamixer -t";
          on-scroll-up = "${pkgs.pamixer}/bin/pamixer -i 5";
          on-scroll-down = "${pkgs.pamixer}/bin/pamixer -d 5";
          smooth-scrolling-threshold = 1;
          tooltip-format = "{desc}\nVolume: {volume}%";
        };

        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = "<span color='${theme.waybar.glyph-color}'>󰍬</span> <span color='${stylix-palette.base05}'>{volume}%</span>";
          format-source-muted = "<span color='${stylix-palette.base04}'>󰍭 Muted</span>";
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol -t 4";
          on-click-right = "${pkgs.pamixer}/bin/pamixer --default-source -t";
          on-scroll-up = "${pkgs.pamixer}/bin/pamixer --default-source -i 5";
          on-scroll-down = "${pkgs.pamixer}/bin/pamixer --default-source -d 5";
          scroll-step = 5;
          smooth-scrolling-threshold = 1;
          tooltip-format = "{source_desc}\nVolume: {source_volume}%";
        };

        clock = {
          interval = 1;
          tooltip = false;
          format = "<span color='${theme.waybar.glyph-color}'> </span><span color='${stylix-palette.base05}'>{:%T}</span>";
        };

        network = {
          format-wifi = "<span color='${theme.waybar.glyph-color}'>{icon}</span><span color='${stylix-palette.base05}'>{essid}</span>";
          format-icons = ["󰤯 " "󰤟 " "󰤢 " "󰤥 " "󰤨 "];
          format-ethernet = "<span color='${theme.waybar.glyph-color}'>󰈀 </span><span color='${stylix-palette.base05}'>Connected</span>";
          format-disconnected = "<span color='${theme.waybar.glyph-color}'>󰤭 </span><span color='${stylix-palette.base05}'>Disconnected</span>";
          format-disabled = "<span color='${stylix-palette.base04}'>󰤮 Disabled</span>";
          tooltip-format-wifi = "  Signal intensity: {signalStrength}% \nIP: {ipaddr}\n {bandwidthDownBytes}   {bandwidthUpBytes}";
          tooltip-format-ethernet = "󰈀 {ifname}\nIP: {ipaddr}\n {bandwidthDownBytes}   {bandwidthUpBytes}";
          tooltip-format-disconnected = "󰤭  Disconnected \n<span color='${stylix-palette.base0A}'>Left-click</span> to \nmanage connections";
          tooltip-format-disabled = "󰤮  Connection disabled \n<span color='${stylix-palette.base0A}'>Right-click</span> to enable";
          on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
          on-click-right = "${pkgs.util-linux}/bin/rfkill toggle wifi";
          interval = 5;
          nospacing = 1;
        };

        bluetooth = {
          format = "<span color='${theme.waybar.glyph-color}'> </span><span color='${stylix-palette.base05}'>Enabled</span>";
          format-disabled = "<span color='${stylix-palette.base04}'>󰂲 Disabled</span>";
          format-off = "<span color='${stylix-palette.base04}'>󰂲 Disabled</span>";
          format-connected = "<span color='${theme.waybar.glyph-color}'> </span><span color='${stylix-palette.base05}'>{device_alias}</span> <span color='${stylix-palette.base0A}'>[</span><span color='${stylix-palette.base05}'>{num_connections}</span><span color='${stylix-palette.base0A}'>]</span>";
          format-connected-battery = "<span color='${theme.waybar.glyph-color}'> </span><span color='${stylix-palette.base05}'>{device_alias}</span> <span color='${stylix-palette.base0A}'>(</span><span color='${stylix-palette.base05}'>{device_battery_percentage}%</span><span color='${stylix-palette.base0A}'>)</span> <span color='${stylix-palette.base0A}'>[</span><span color='${stylix-palette.base05}'>{num_connections}</span><span color='${stylix-palette.base0A}'>]</span>";
          tooltip-format = "{controller_alias}\t{controller_address}\nStatus: {status}";
          tooltip-format-disabled = "󰂲 Bluetooth disabled \nRight-click to enable";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n{num_connections} connected device(s)\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          on-click = "${pkgs.blueman}/bin/blueman-manager";
          on-click-right = "${pkgs.util-linux}/bin/rfkill toggle bluetooth";
        };

        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "<span color='${stylix-palette.base05}'>{capacity}%</span> <span color='${theme.waybar.glyph-color}'>{icon}</span>";
          format-icons = {
            charging = ["󰁺󱐋" "󰁻󱐋" "󰁼󱐋" "󰁽󱐋" "󰁾󱐋" "󰁿󱐋" "󰂀󱐋" "󰂁󱐋" "󰂂󱐋" "󰁹󱐋"];
            default = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          };
          format-full = "<span color='${stylix-palette.base05}'>Charged</span> <span color='${theme.waybar.glyph-color}'></span>";
          format-time = "{H}h {M}min";
          tooltip-format = "{timeTo}\nPower: {power} W\nHealth: {health}%";
        };

        tray = {
          spacing = 10;
          show-passive-items = true;
        };
      };
    };

    style = ''
      * {
        min-height: 0;
        min-width: 0;
        font-family: "${theme.waybar.font}", "${stylix-fonts.emoji.name}";
        font-size: ${theme.waybar.font-size}px;
        font-weight: 600;
      }

      window#waybar {
        background-color: transparent;
      }

      window#waybar.hidden {
        opacity: 0.6;
      }

      #workspaces {
        background-color: ${theme.waybar.background-color};
        padding: 0.3rem 0.6rem;
        margin: 0.2rem;
        border-radius: 13px;
        border: 2px solid ${stylix-palette.base0A};
      }

      #workspaces button {
        padding: 0.3rem 1rem;
        margin: 0.2rem;
        border-radius: 13px;
        background-color: transparent;
        color: ${stylix-palette.base0A};
      }

      #workspaces button.active {
        color: ${stylix-palette.base01};
        background-color: ${stylix-palette.base05};
      }

      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        color: ${stylix-palette.base01};
        background-color: ${stylix-palette.base05};
      }

      #workspaces button.urgent {
        color: ${stylix-palette.base01};
        background-color: ${stylix-palette.base0A};
      }

      #window,
      #mpd,
      #cava,
      #cpu,
      #memory,
      #pulseaudio,
      #clock,
      #battery,
      #bluetooth,
      #network,
      #tray {
        padding: 0.3rem 0.6rem;
        margin: 0.2rem;
        border-radius: 13px;
        border: 2px solid ${stylix-palette.base0A};
        background-color: ${theme.waybar.background-color};
      }

      window#waybar.empty #window {
        background-color: transparent;
      }

      #memory {
        color: ${stylix-palette.base09};
      } 

      #battery {
        color: ${stylix-palette.base0A};
      }

      #battery.charging {
        color: ${stylix-palette.base0B};
      }

      @keyframes blink {
        to {
          color: ${stylix-palette.base0F};
        }
      }

      #battery.warning,
      #battery.critical,
      #battery.urgent {
        color: ${stylix-palette.base08};
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      clock#simpleclock {
        padding-right: 16px;
      }

      tooltip {
        border-radius: 8px;
        padding: 15px;
        background-color: ${theme.waybar.background-color};
      }

      tooltip label {
        color: ${stylix-palette.base05};
      }
    '';
  };
}
