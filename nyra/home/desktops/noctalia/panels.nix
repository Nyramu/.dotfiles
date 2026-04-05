{ ... }:

{
  programs.noctalia-shell = {
    settings = {
      controlCenter = {
        position = "close_to_bar_button";
        diskPath = "/";
        shortcuts = {
          left = [
            {
              id = "plugin:timer";
            }
            {
              id = "WallpaperSelector";
            }
          ];
          right = [
            {
              id = "Notifications";
            }
            {
              id = "NightLight";
            }
          ];
        };
        cards = [
          {
            enabled = true;
            id = "profile-card";
          }
          {
            enabled = true;
            id = "shortcuts-card";
          }
          {
            enabled = true;
            id = "weather-card";
          }
          {
            enabled = false;
            id = "media-sysmon-card";
          }
          {
            enabled = false;
            id = "brightness-card";
          }
          {
            enabled = false;
            id = "audio-card";
          }
        ];
      };

      sessionMenu = {
        position = "top_center";
        showHeader = true;
        showKeybinds = true;
        largeButtonsStyle = false;
        powerOptions = [
          {
            action = "lock";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "1";
          }
          {
            action = "reboot";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "2";
          }
          {
            action = "shutdown";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "3";
          }
          {
            action = "logout";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "4";
          }
          {
            action = "rebootToUefi";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "5";
          }
          {
            action = "suspend";
            command = "";
            countdownEnabled = true;
            enabled = false;
          }
          {
            action = "hibernate";
            command = "";
            countdownEnabled = true;
            enabled = false;
          }
        ];
      };
    };
  };
}
