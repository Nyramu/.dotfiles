{ config, pkgs, ... }: 

let
  themeName = config.nyra.theme.defaultTheme;
  theme = import ../../../../resources/themes/${themeName}.nix { inherit pkgs; };
  timezone =
    pkgs.runCommand "timezone" {} ''echo $(timedatectl show --property=Timezone --value) > $out'';
in 
{
  programs.waybar = {
    enable = config.nyra.home.desktops.hyprland.enable;

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
          "hyprland/workspaces" 
        ];
        modules-center = [
          "tray"
        ];
        modules-right = [
          "cpu"
          "memory"
          "pulseaudio"
          "clock"
          "clock#simpleclock"
          "network"
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
          interval = 5;
          format = " {icon}";
          format-icons = ["╸    " "━╸   " "━━╸  " "━━━╸ " "━━━━╸" "━━━━━"];
        };

        memory = {
          interval = 5;
          format = " {icon}";
          format-icons = ["╸    " "━╸   " "━━╸  " "━━━╸ " "━━━━╸" "━━━━━"];
        };

        pulseaudio = {
          tooltip-format = "Volume : {volume}%";
          format = "{icon}";
          format-muted = "       ";
          format-icons = {
            default = ["     " " ╸   " " ━╸  " " ━━╸ " " ━━━╸" " ━━━━"];
          };
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };

        clock = {
          interval = 1;
          format = "󰸘 {:L%a %d %b}";
          timezone = "${timezone}";
          tooltip-format = ''<tt>{calendar}</tt>'';

          calendar.format = {
            today = "<span color='#${theme.palette.base0E}' weight='700'>{}</span>";
          };
        };

        "clock#simpleclock" = {
          tooltip = false;
          format = " {:%H:%M}";
        };

        network = {
          format-wifi = "{icon}";
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          format-ethernet = "󰀂";
          format-alt = "󱛇";
          format-disconnected = "󰖪";
          tooltip-format-wifi = "{icon} {essid}\n {bandwidthDownBytes}   {bandwidthUpBytes}";
          tooltip-format-ethernet = "󰀂  {ifname}\n {bandwidthDownBytes}   {bandwidthUpBytes}";
          tooltip-format-disconnected = "Disconnesso";
          interval = 5;
          nospacing = 1;
        };

        bluetooth = {
	        format = " {status}";
	        format-connected = " {device_alias}";
	        format-connected-battery = " {device_alias} {device_battery_percentage}%";
          # "format-device-preference": [ "device1", "device2" ]; # preference list deciding the displayed device
        	tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
	        tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
	        tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
	        tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
        };

        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-icons = {
            charging = ["󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
            default = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          };
          format-full = "Carica ";
          tooltip = false;
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
      #bluetooth
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

      #memory,
      #cpu {
        color: #${theme.palette.base09};
      }

      #pulseaudio {
        color: #${theme.palette.base0A};
      }

      #battery {
        color: #${theme.palette.base0A};
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

      #battery.charging {
        color: #${theme.palette.base0B};
      }

      #network,
      #bluetooth {
        color: #${theme.palette.base0A};
        padding-right: 16px;
      }

      #clock {
        color: #${theme.palette.base0A};
      }

      tooltip {
        border-radius: 8px;
        padding: 15px;
        background-color: ${theme.waybar.background-color};
      }
    '';
  };
}
