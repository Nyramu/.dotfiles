{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

let
  theme = import ../../../resources/themes/${config.nyra.theme.defaultTheme}.nix { inherit pkgs; };
  cfg = config.nyra.desktops;
in
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia-shell = {
    enable = cfg.hyprland.enable;
    systemd.enable = true;
    settings = {
      location.name = "Sassari";
      ui = {
        fontDefaultScale = theme.noctalia.ui.fontDefaultScale or 1;
        fontFixedScale = theme.noctalia.ui.fontFixedScale or 1;
        boxBorderEnabled = true;
        tooltipsEnabled = false;
        wifiDetailsViewMode = "list";
        bluetoothDetailsViewMode = "list";
        bluetoothHideUnnamedDevices = true;
      };
      audio = {
        cavaFrameRate = 60;
        visualizerType = "mirrored";
        volumeOverdrive = true;
        mprisBlacklist = [
          "Mozilla zen"
          "Telegram Desktop"
          "AyuGram Desktop"
        ];
        preferredPlayer = "MPD";
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
        barType = "simple";
        position = "top";
        monitors = [ ];
        density = "spacious";
        capsuleColorKey = "none";
        showOutline = false;
        showCapsule = false;
        useSeparateOpacity = false;
        floating = false;
        marginVertical = 6;
        marginHorizontal = 4;
        frameThickness = 8;
        frameRadius = 12;
        outerCorners = true;
        exclusive = true;
        displayMode = "always_visible";
        autoHideDelay = 100;
        autoShowDelay = 150;
        hideOnOverview = false;
        widgets = {
          left = [
            {
              deviceNativePath = "__default__";
              displayMode = "icon-always";
              hideIfNotDetected = true;
              hideIfIdle = false;
              id = "Battery";
              showNoctaliaPerformance = true;
              showPowerProfiles = false;
              warningThreshold = 30;
            }
            {
              characterCount = 2;
              colorizeIcons = true;
              focusedColor = "primary";
              occupiedColor = "secondary";
              emptyColor = "tertiary";
              enableScrollWheel = true;
              followFocusedScreen = false;
              groupedBorderOpacity = 1;
              hideUnoccupied = false;
              iconScale = 0.8;
              pillSize = 0.67;
              id = "Workspace";
              labelMode = "index";
              showBadge = true;
              showApplications = false;
              showLabelsOnlyWhenOccupied = true;
              unfocusedIconsOpacity = 0.5;
            }
            {
              id = "plugin:privacy-indicator";
            }
            {
              blacklist = [ ];
              chevronColor = "primary";
              colorizeIcons = true;
              drawerEnabled = true;
              pinned = [
                "AyuGram Desktop"
              ];     
              hidePassive = false;
              id = "Tray";
            }
          ];
          center = [
            {
              compactMode = true;
              compactShowAlbumArt = true;
              compactShowVisualizer = false;
              hideMode = "hidden";
              hideWhenIdle = false;
              id = "MediaMini";
              maxWidth = 500;
              panelShowAlbumArt = true;
              panelShowVisualizer = true;
              scrollingMode = "hover";
              showAlbumArt = true;
              showArtistFirst = true;
              showProgressRing = true;
              showVisualizer = false;
              useFixedWidth = false;
              visualizerType = "linear";
            }
          ];
          right = [
            # {
            #   id = "plugin:todo";
            # }
            {
              displayMode = "alwaysShow";
              id = "Volume";
              middleClickCommand = "pwvucontrol || pavucontrol";
              iconColor = "primary";
              textColor = "secondary";
            }
            {
              displayMode = "alwaysShow";
              id = "Microphone";
              middleClickCommand = "pwvucontrol  pavucontrol";
              iconColor = "primary";
              textColor = "secondary";
            }
            {
              displayMode = "alwaysShow";
              id = "Network";
              iconColor = "primary";
              textColor = "secondary";
            }
            {
              displayMode = "onhover";
              id = "Bluetooth";
              iconColor = "primary";
              textColor = "secondary";
            }
            {
              formatHorizontal = "HH:mm:ss";
              formatVertical = "HH:mm:ss --------- dd/MM/yyyy";
              id = "Clock";
              tooltipFormat = "dddd, dd/MM/yyyy";
              useCustomFont = false;
              clockColor = "primary";
            }
          ];
        };
      };
      controlCenter = {
        position = "close_to_bar_button";
        diskPath = "/";
        shortcuts = {
          left = [
            { id = "plugin:timer"; }
            { id = "Notifications"; }
            { id = "NightLight"; }
          ];
          right = [ ];
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
      notifications = {
        enabled = false;
        location = "top";
        overlayLayer = true;
        backgroundOpacity = 0.7;
        respectExpireTimeout = true;
        lowUrgencyDuration = 3;
        normalUrgencyDuration = 3;
        criticalUrgencyDuration = 3;
        enableKeyboardLayoutToast = true;
        saveToHistory = {
          low = true;
          normal = true;
          critical = true;
        };
        enableMediaToast = false;
        sounds.enabled = false;
      };
      osd = {
        enabled = true;
        location = "top";
        autoHideMs = 600;
        overlayLayer = true;
        enabledTypes = [
          0
          2
          3
        ];
        monitors = [ ];
      };
      general = {
        avatarImage = ../../../resources/nyramu.png;
        radiusRatio = 0.5;
        iRadiusRatio = 0.6;
        compactLockScreen = true;
        autoStartAuth = true;
        allowPasswordWithFprintd = true;
        lockOnSuspend = false;
        showSessionButtonsOnLockScreen = true;
        shadowDirection = "bottom";
        shadowOffsetX = 0;
        shadowOffsetY = 3;
        animationSpeed = 1.2;
        telemetryEnabled = true;
        clockStyle = "custom";
        clockFormat = "HH:mm:ss\\n--------\\ndd/MM/yyyy";
      };
      network = {
        bluetoothRssiPollingEnabled = true;
        bluetoothHideUnnamedDevices = true;
      };
      location = {
        analogClockInCalendar = theme.noctalia.ui.analogClockInCalendar or true;
        showWeekNumberInCalendar = true;
        weatherShowEffects = false;
        firstDayOfWeek = 1;
      };
      calendar = {
        cards = [
          {
            enabled = true;
            id = "calendar-header-card";
          }
          {
            enabled = true;
            id = "calendar-month-card";
          }
          {
            enabled = false;
            id = "weather-card";
          }
        ];
      };
      sessionMenu = {
        position = "top_center";
        largeButtonsStyle = false;
        powerOptions = [
          {
            action = "lock";
            command = "";
            countdownEnabled = true;
            enabled = true;
          }
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
      plugins.autoUpdate = true;
      wallpaper.enabled = true;
      dock.enabled = false;
      hooks.enabled = false;
      desktopWidgets.enabled = false;
      sounds.enabled = false;
    };
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        privacy-indicator = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        weather-indicator = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        todo = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        timer = {
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
      todo = {
        pages = [
          {
            id = 0;
            name = "General";
          }
          {
            id = 1;
            name = "Dotfiles";
          }
        ];
        showCompleted = true;
        showBackground = false;
      };
    };
    colors = lib.mkIf (config.stylix.enable) {
      mPrimary = lib.mkIf (theme ? noctalia.colors.mPrimary) (lib.mkForce theme.noctalia.colors.mPrimary);
      mHover = lib.mkIf (theme ? noctalia.colors.mHover) (lib.mkForce theme.noctalia.colors.mHover);
      mOnHover = lib.mkIf (theme ? noctalia.colors.mOnHover) (lib.mkForce theme.noctalia.colors.mOnHover);
    };
  };
}
