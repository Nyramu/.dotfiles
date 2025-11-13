{ config, lib, pkgs, ... }: 

let
  cfgHyprEnable = config.nyra.home.desktops.hyprland.enable; 
  themeName = config.nyra.theme.defaultTheme;
  theme = import ../../../../resources/themes/${themeName}.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; lib.optionals cfgHyprEnable [ networkmanagerapplet ];
  programs.waybar = {
    enable = cfgHyprEnable;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 45;
        spacing = 3;
        exclusive = true;
        gtk-layer-shell = true;
        passthrough = false;
        fixed-center = true;

        modules-left = [
          "cpu"
          "memory"
          "tray"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "pulseaudio"
          "pulseaudio#microphone"
          "network"
          "bluetooth"
          "clock"
          "battery"
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

        "hyprland/window" = {
          format = "{initialTitle}";
        };
        
        cpu = {
          interval = 3;
          format = "<span color='#${theme.palette.base0A}'> </span> <span color='#${theme.palette.base05}'>{usage}%</span> <span color='#${theme.palette.base0A}'>|</span> <span color='#${theme.palette.base05}'>{avg_frequency} GHz</span>";
          tooltip = false;
        };

        memory = {
          interval = 3;
          format = "<span color='#${theme.palette.base0A}'> </span> <span color='#${theme.palette.base05}'>{percentage}%</span> <span color='#${theme.palette.base0A}'>|</span> <span color='#${theme.palette.base05}'>{used:0.1f} GB/{total:0.1f} GB</span>";
          tooltip = false; # TODO: decide to put or not btop 'quick launch'
        };

        pulseaudio = {
          format = "<span color='#${theme.palette.base0A}'>{icon}</span> <span color='#${theme.palette.base05}'>{volume}%</span>";
          format-muted = "<span color='#${theme.palette.base03}'>󰖁 Muted</span>";
          format-icons = {
            default = ["󰕿" "󰖀" "󰕾"];
            headphone = "󰋋";
            headset = "󰋎";
            portable = "";
            speaker = "󰓃";
            hdmi = "󰡁";
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
          format-source = "<span color='#${theme.palette.base0A}'>󰍬</span> <span color='#${theme.palette.base05}'>{volume}%</span>";
          format-source-muted = "<span color='#${theme.palette.base03}'>󰍭 Muted</span>";
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
          format = "<span color='#${theme.palette.base0A}'></span> <span color='#${theme.palette.base05}'>{:%T}</span>";
        };

        network = {
          format-wifi = "<span color='#${theme.palette.base0A}'>{icon} </span> <span color='#${theme.palette.base05}'>{essid}</span>";
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          format-ethernet = "<span color='#${theme.palette.base0A}'>󰈀 </span> <span color='#${theme.palette.base05}'>Connected</span>";
          format-disconnected = "<span color='#${theme.palette.base0A}'>󰖪 </span> <span color='#${theme.palette.base05}'>Disconnected</span>";
          format-disabled = "<span color='#${theme.palette.base03}'>󰖪  Disabled</span>";
          tooltip-format-wifi = "Signal intensity: {signalStrength}% \nIP: {ipaddr}\n {bandwidthDownBytes}   {bandwidthUpBytes}";
          tooltip-format-ethernet = "󰈀 {ifname}\nIP: {ipaddr}\n {bandwidthDownBytes}   {bandwidthUpBytes}";
          tooltip-format-disconnected = "󰖪  Disconnected \nLeft-click to \nmanage connections";
          tooltip-format-disabled = "󰖪  Connection disabled \nRight-click to enable";
          on-click = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
          on-click-right = "${pkgs.util-linux}/bin/rfkill toggle wifi";
          interval = 5;
          nospacing = 1;
        };

        bluetooth = {
          format = "<span color='#${theme.palette.base0A}'></span> <span color='#${theme.palette.base05}'>Enabled</span>";
          format-disabled = "<span color='#${theme.palette.base03}'>󰂲 Disabled</span>";
          format-off = "<span color='#${theme.palette.base03}'>󰂲 Disabled</span>";
          format-connected = "<span color='#${theme.palette.base0A}'></span> <span color='#${theme.palette.base05}'>{device_alias}</span> <span color='#${theme.palette.base0A}'>[</span><span color='#${theme.palette.base05}'>{num_connections}</span><span color='#${theme.palette.base0A}'>]</span>";
          format-connected-battery = "<span color='#${theme.palette.base0A}'></span> <span color='#${theme.palette.base05}'>{device_alias}</span> <span color='#${theme.palette.base0A}'>(</span><span color='#${theme.palette.base05}'>{device_battery_percentage}%</span><span color='#${theme.palette.base0A}'>)</span> <span color='#${theme.palette.base0A}'>[</span><span color='#${theme.palette.base05}'>{num_connections}</span><span color='#${theme.palette.base0A}'>]</span>";
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
          format = "<span color='#${theme.palette.base05}'>{capacity}%</span> <span color='#${theme.palette.base0A}'>{icon}</span>";
          format-icons = {
            charging = ["󰁺󱐋" "󰁻󱐋" "󰁼󱐋" "󰁽󱐋" "󰁾󱐋" "󰁿󱐋" "󰂀󱐋" "󰂁󱐋" "󰂂󱐋" "󰁹󱐋"];
            default = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          };
          format-full = "<span color='#${theme.palette.base05}'>Charged</span> <span color='#${theme.palette.base0A}'></span>";
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
        font-family: ${theme.fonts.monospace.name}, ${theme.fonts.sansSerif.name};
        font-size: 14px;
        font-weight: 600;
      }

      window#waybar {
        background-color: ${theme.waybar.background-color};
      }

      window#waybar.hidden {
        opacity: 0.6;
      }

      #workspaces {
        background-color: transparent;
      }

      #workspaces button {
        padding: 0.3rem 1rem;
        margin: 0.2rem;
        border-radius: 6px;
        background-color: transparent;
        color: #${theme.palette.base0A};
      }

      #workspaces button.active {
        color: #${theme.palette.base01};
        background-color: #${theme.palette.base05};
      }

      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        color: #${theme.palette.base01};
        background-color: #${theme.palette.base05};
      }

      #workspaces button.urgent {
        background-color: #${theme.palette.base08};
      }

      #window,
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
        border-radius: 6px;
        background-color: transparent;
      }

      window#waybar.empty #window {
        background-color: transparent;
      }

      #memory
       {
        color: #${theme.palette.base09};
      } 

      #battery {
        color: #${theme.palette.base0A};
      }

      #battery.charging {
        color: #${theme.palette.base0B};
      }

      @keyframes blink {
        to {
          color: #${theme.palette.base0F};
        }
      }

      #battery.warning,
      #battery.critical,
      #battery.urgent {
        color: #${theme.palette.base08};
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
        color: #${theme.palette.base05};
      }
    '';
  };
}
