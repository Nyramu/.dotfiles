{ config, lib, ... }:

let
  cfg = config.nyra.home.apps.fastfetch;
in
{
  options.nyra.home.apps.fastfetch = {
    enable = lib.mkEnableOption "fastfetch";
    logo = lib.mkOption {
      type = lib.types.enum [ "burrito-ascii" ];
      default = "burrito-ascii";
    };
  };

  config = {
    programs.fastfetch = {
      enable = cfg.enable;
      settings = {
        logo = {
          type = "auto";
          source = ../../../../resources/pics/${cfg.logo}.png;
        };
        modules = [
          "break"
          {
            "type" = "custom";
            "format" = "┌──────────────────────Hardware──────────────────────┐";
          }
          {
            "type" = "host";
            "key" = " PC ";
          }
          {
            "type" = "cpu";
            "key" = "│ ├ ";
          }
          {
            "type" = "gpu";
            "key" = "│ ├ ";
          }
          {
            "type" = "memory";
            "key" = "│ ├ ";
          }
          {
            "type" = "disk";
            "key" = "│ ├ ";
          }
          {
            "type" = "display";
            "key" = "│ ├󰍹 ";
          }
          {
            "type" = "battery";
            "key" = "└ └ ";
          }
          {
            "type" = "custom";
            "format" = "└────────────────────────────────────────────────────┘";
          }

          "break"
          {
            "type" = "custom";
            "format" = "┌──────────────────────Software──────────────────────┐";
          }
          {
            "type" = "os";
            "key" = " OS ";
          }
          {
            "type" = "kernel";
            "key" = "│ ├󰹣 ";
          }
          {
            "type" = "bios";
            "key" = "│ ├ ";
            "format" = "{type} {vendor} {version}";
          }
          {
            "type" = "title";
            "key" = "│ ├ ";
            "format" = "{host-name}";
          }
          {
            "type" = "shell";
            "key" = "└ └ ";
          }
          "break"
          {
            "type" = "wm";
            "key" = " WM ";
          }
          {
            "type" = "title";
            "key" = "│ ├ ";
            "format" = "{user-name}";
          }
          {
            "type" = "lm";
            "key" = "│ ├󰍂 ";
          }
          {
            "type" = "terminal";
            "key" = "└ └ ";
          }
          {
            "type" = "custom";
            "format" = "└────────────────────────────────────────────────────┘";
          }

          "break"
          {
            "type" = "custom";
            "format" = "┌──────────────────Age / Uptime / DT─────────────────┐";
          }
          {
            "type" = "command";
            "key" = "  OS Age ";
            "text" =
              "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
          }
          {
            "type" = "uptime";
            "key" = "  Uptime ";
          }
          {
            "type" = "datetime";
            "key" = "  Date and Time";
            "format" =
              "{weekday} {day-pretty}/{month-pretty}/{year} | {hour-pretty}:{minute-pretty}:{second-pretty}";
          }
          {
            "type" = "custom";
            "format" = "└────────────────────────────────────────────────────┘";
          }

          {
            "type" = "colors";
            "paddingLeft" = 2;
            "symbol" = "circle";
          }
        ];
      };
    };
  };
}
