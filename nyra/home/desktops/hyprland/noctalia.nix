{ config, inputs, ... }:

let
  cfgHyprland = config.nyra.home.desktops.hyprland;
in
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = cfgHyprland.enable;
    systemd.enable = true;
    settings = {
      location.name = "Sassari";
      ui.tooltipsEnabled = false;
      audio = {
        cavaFrameRate = 60;
        visualizerType = "mirrored";
        mprisBlacklist = [
          "Mozilla zen"
          "Telegram Desktop"
        ];
        preferredPlayer = "";
      };
      nightLight = {
        enabled = false;
        forced = false;
        autoSchedule = true;
        nightTemp = "5000";
        dayTemp = "6500";
        manualSunrise = "06:30";
        manualSunset = "21:30";
      };   
      bar = {
        position = "top";
        monitors = [];
        density = "spacious";
        showOutline = false;
        showCapsule = false;
        useSeparateOpacity = false;
        floating = false;
        marginVertical = 6;
        marginHorizontal = 4;
        outerCorners = false;
        exclusive = true;
        hideOnOverview = false;
        widgets = {
          left = [
            {
              deviceNativePath = "";
              displayMode = "alwaysShow";
              hideIfNotDetected = true;
              id = "Battery";
              showNoctaliaPerformance = true;
              showPowerProfiles = false;
              warningThreshold = 30;
            }
            {
              id = "Spacer";
              width = 5;
            }
            {
              characterCount = 2;
              colorizeIcons = false;
              enableScrollWheel = true;
              followFocusedScreen = false;
              groupedBorderOpacity = 1;
              hideUnoccupied = false;
              iconScale = 0.8;
              id = "Workspace";
              labelMode = "index";
              showApplications = false;
              showLabelsOnlyWhenOccupied = true;
              unfocusedIconsOpacity = 1;
            }
            {
              blacklist = [];
              colorizeIcons = false;
              drawerEnabled = false;
              hidePassive = false;
              id = "Tray";
              pinned = [];
            }
          ];
          center = [
            {
              colorizeDistroLogo = false;
              colorizeSystemIcon = "none";
              customIconPath = "";
              enableColorization = false;
              icon = "noctalia";
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              colorName = "primary";
              hideWhenIdle = true;
              id = "AudioVisualizer";
              width = 200;
            }
          ];
          right = [
            {
              displayMode = "alwaysShow";
              id = "Volume";
              middleClickCommand = "pwvucontrol || pavucontrol";
            }
            {
              displayMode = "alwaysShow";
              id = "Network";
            }
            {
              displayMode = "alwaysShow";
              id = "Bluetooth";
            }
            {
              customFont = "";
              formatHorizontal = "HH:mm:ss";
              formatVertical = "HH mm - dd MM";
              id = "Clock";
              tooltipFormat = "dddd, dd/MM/yyyy";
              useCustomFont = false;
              usePrimaryColor = false;
            }
          ];
        };
      };
      controlCenter = {
        position = "close_to_bar_button";
        diskPath = "/";
        shortcuts = {
          left = [
            { id = "Notifications"; }
            { id = "NightLight"; }
            { id = "PowerProfile"; }
          ];
          right = [];
        };
        cards = [
          { enabled = true; id = "profile-card"; }
          { enabled = true; id = "brightness-card"; }
          { enabled = true; id = "media-sysmon-card"; }
          { enabled = true; id = "weather-card"; }
          { enabled = false; id = "shortcuts-card"; }
          { enabled = false; id = "audio-card"; }
        ];
      };
      osd = {
        enabled = true;
        location = "top";
        autoHideMs = 600;
        overlayLayer = true;
        enabledTypes = [3];
        monitors = [];
      };
      general = {
        avatarImage = ../../../../resources/nyramu.png;
        radiusRatio = 0.6;
        iRadiusRatio = 0.6;
        compactLockScreen = true;
        lockOnSuspend = false;
        showSessionButtonsOnLockScreen = true;
        shadowDirection = "bottom";
        shadowOffsetX = 0;
        shadowOffsetY = 3;
        telemetryEnabled = false;
      };
      network = {
        bluetoothRssiPollingEnabled = true;
        bluetoothHideUnnamedDevices = true;
      };
      location = {
        analogClockInCalendar = true;
        firstDayOfWeek = 1;
      };
      calendar = {
        cards = [
          { enabled = true; id = "calendar-header-card"; }
          { enabled = true; id = "calendar-month-card"; }
          { enabled = false; id = "weather-card"; }
        ];
      };
      sessionMenu = {
        powerOptions = [
          {
            action = "reboot";
            command = "";
            countdownEnabled = true;
            enabled = true;
          }
          {
            action = "shutdown";
            command = "";
            countdownEnabled = true;
            enabled = true;
          }
          {
            action = "logout";
            command = "";
            countdownEnabled = true;
            enabled = true;
          }
          {
            action = "lock";
            command = "";
            countdownEnabled = true;
            enabled = false;
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
      wallpaper.enabled = false;
      dock.enabled = false;
      hooks.enabled = false;
      desktopWidgets.enabled = false;
      sounds.enabled = false;
      notifications.enabled = false;
    };
  };
}
