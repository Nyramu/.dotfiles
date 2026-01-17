{ config, lib, inputs, pkgs, ... }:

let
  cfg = config.nyra.home.desktops;
  themeName = config.nyra.theme.defaultTheme;
  theme = import ../../../resources/themes/${themeName}.nix {inherit pkgs;};
in
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = cfg.hyprland.enable;
    systemd.enable = true;
    settings = {
      location.name = "Sassari";
      ui = {
        fontDefaultScale = theme.noctalia.ui.fontDefaultScale or 1;
        fontFixedScale = theme.noctalia.ui.fontFixedScale or 1;
        tooltipsEnabled = false;
      };
      audio = {
        cavaFrameRate = 60;
        visualizerType = "mirrored";
        volumeOverdrive = true;
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
        outerCorners = true;
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
              id = "plugin:privacy-indicator";
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
              colorizeDistroLogo = true;
              colorizeSystemIcon = theme.noctalia.colors.control-center-logo or "none";
              customIconPath = "";
              enableColorization = true;
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
              usePrimaryColor = true;
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
        avatarImage = ../../../resources/nyramu.png;
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
        analogClockInCalendar = theme.noctalia.ui.analogClockInCalendar or true;
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
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        privacy-indicator = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
    };
    pluginSettings = {
      privacy-indicator = {
        hideInactive = true;
        iconSpacing = 9;
        removeMargins = false;
      };
    };
    colors = lib.mkIf (config.stylix.enable) {
      mPrimary = lib.mkIf (theme ? noctalia.colors.mPrimary) (lib.mkForce theme.noctalia.colors.mPrimary);
      mHover = lib.mkIf (theme ? noctalia.colors.mHover) (lib.mkForce theme.noctalia.colors.mHover);
      mOnHover = lib.mkIf (theme ? noctalia.colors.mOnHover) (lib.mkForce theme.noctalia.colors.mOnHover);
    };
  };
}
