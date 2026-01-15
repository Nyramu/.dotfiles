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
    systemd.enable = true; # Needed for auto-restart and gui config
    settings = {
      settingsVersion = 0;
      bar = {
        position = "top";
        monitors = [];
        density = "spacious";
        showOutline = false;
        showCapsule = true;
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
            {
              id = "plugin:pomodoro";
            }
          ];
        };
      };
      general = {
        avatarImage = ../../../../resources/nyramu.png;
        dimmerOpacity = 0.2;
        showScreenCorners = false;
        forceBlackScreenCorners = false;
        scaleRatio = 1;
        radiusRatio = 1;
        iRadiusRatio = 1;
        boxRadiusRatio = 1;
        screenRadiusRatio = 1;
        animationSpeed = 1;
        animationDisabled = false;
        compactLockScreen = true;
        lockOnSuspend = false;
        showSessionButtonsOnLockScreen = true;
        showHibernateOnLockScreen = false;
        enableShadows = true;
        shadowDirection = "bottom";
        shadowOffsetX = 0;
        shadowOffsetY = 3;
        language = "";
        allowPanelsOnScreenWithoutBar = true;
        showChangelogOnStartup = true;
        telemetryEnabled = false;
      };
      ui = {
        tooltipsEnabled = true;
        panelsAttachedToBar = true;
        settingsPanelMode = "attached";
        wifiDetailsViewMode = "grid";
        bluetoothDetailsViewMode = "grid";
        networkPanelView = "wifi";
        bluetoothHideUnnamedDevices = false;
        boxBorderEnabled = false;
      };
      location = {
        name = "Sassari";
        weatherEnabled = true;
        weatherShowEffects = true;
        useFahrenheit = false;
        use12hourFormat = false;
        showWeekNumberInCalendar = false;
        showCalendarEvents = true;
        showCalendarWeather = true;
        analogClockInCalendar = false;
        firstDayOfWeek = 1;
        hideWeatherTimezone = false;
        hideWeatherCityName = false;
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
            enabled = true;
            id = "weather-card";
          }
        ];
      };
      wallpaper = {
        enabled = true;
        overviewEnabled = false;
        directory = "";
        monitorDirectories = [];
        enableMultiMonitorDirectories = false;
        recursiveSearch = false;
        setWallpaperOnAllMonitors = true;
        fillMode = "crop";
        fillColor = "#000000";
        useSolidColor = false;
        solidColor = "#1a1a2e";
        randomEnabled = false;
        wallpaperChangeMode = "random";
        randomIntervalSec = 300;
        transitionDuration = 1500;
        transitionType = "random";
        transitionEdgeSmoothness = 0.05;
        panelPosition = "follow_bar";
        hideWallpaperFilenames = false;
        useWallhaven = false;
        wallhavenQuery = "";
        wallhavenSorting = "relevance";
        wallhavenOrder = "desc";
        wallhavenCategories = "111";
        wallhavenPurity = "100";
        wallhavenRatios = "";
        wallhavenApiKey = "";
        wallhavenResolutionMode = "atleast";
        wallhavenResolutionWidth = "";
        wallhavenResolutionHeight = "";
      };
      appLauncher = {
        enableClipboardHistory = false;
        autoPasteClipboard = false;
        enableClipPreview = true;
        clipboardWrapText = true;
        position = "center";
        pinnedApps = [];
        useApp2Unit = false;
        sortByMostUsed = true;
        terminalCommand = "xterm -e";
        customLaunchPrefixEnabled = false;
        customLaunchPrefix = "";
        viewMode = "list";
        showCategories = true;
        iconMode = "tabler";
        showIconBackground = false;
        ignoreMouseInput = false;
        screenshotAnnotationTool = "";
      };
      controlCenter = {
        position = "close_to_bar_button";
        diskPath = "/";
        shortcuts = {
          left = [
            {
              id = "Notifications";
            }
            {
              id = "NightLight";
            }
            {
              id = "PowerProfile";
            }
          ];
          right = [];
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
            enabled = false;
            id = "audio-card";
          }
          {
            enabled = false;
            id = "brightness-card";
          }
          {
            enabled = false;
            id = "weather-card";
          }
          {
            enabled = true;
            id = "media-sysmon-card";
          }
        ];
      };
      systemMonitor = {
        cpuWarningThreshold = 80;
        cpuCriticalThreshold = 90;
        tempWarningThreshold = 80;
        tempCriticalThreshold = 100;
        gpuWarningThreshold = 80;
        gpuCriticalThreshold = 90;
        memWarningThreshold = 80;
        memCriticalThreshold = 90;
        diskWarningThreshold = 80;
        diskCriticalThreshold = 90;
        cpuPollingInterval = 3000;
        tempPollingInterval = 3000;
        gpuPollingInterval = 3000;
        enableDgpuMonitoring = false;
        memPollingInterval = 3000;
        diskPollingInterval = 3000;
        networkPollingInterval = 3000;
        loadAvgPollingInterval = 3000;
        useCustomColors = false;
        warningColor = "";
        criticalColor = "";
        externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
      };
      dock = {
        enabled = false;
        position = "bottom";
        displayMode = "auto_hide";
        floatingRatio = 1;
        size = 1;
        onlySameOutput = true;
        monitors = [];
        pinnedApps = [];
        colorizeIcons = false;
        pinnedStatic = false;
        inactiveIndicators = false;
        deadOpacity = 0.6;
        animationSpeed = 1;
      };
      network = {
        wifiEnabled = true;
        bluetoothRssiPollingEnabled = true;
        bluetoothRssiPollIntervalMs = 10000;
        wifiDetailsViewMode = "grid";
        bluetoothDetailsViewMode = "grid";
        bluetoothHideUnnamedDevices = false;
      };
      sessionMenu = {
        enableCountdown = true;
        countdownDuration = 10000;
        position = "center";
        showHeader = true;
        largeButtonsStyle = false;
        largeButtonsLayout = "grid";
        showNumberLabels = true;
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
      notifications = {
        enabled = true;
        monitors = [];
        location = "top";
        overlayLayer = true;
        respectExpireTimeout = false;
        lowUrgencyDuration = 1;
        normalUrgencyDuration = 1;
        criticalUrgencyDuration = 3;
        enableKeyboardLayoutToast = true;
        saveToHistory = {
          low = false;
          normal = true;
          critical = true;
        };
        sounds = {
          enabled = false;
          volume = 0.5;
          separateSounds = false;
          criticalSoundFile = "";
          normalSoundFile = "";
          lowSoundFile = "";
          excludedApps = "discord,firefox,chrome,chromium,edge";
        };
      };
      osd = {
        enabled = true;
        location = "top";
        autoHideMs = 500;
        overlayLayer = true;
        enabledTypes = [0 2 3];
        monitors = [];
      };
      audio = {
        volumeStep = 5;
        volumeOverdrive = false;
        cavaFrameRate = 60;
        visualizerType = "mirrored";
        mprisBlacklist = [
          "Mozilla zen"
        ];
        preferredPlayer = "";
      };
      brightness = {
        brightnessStep = 5;
        enforceMinimum = true;
        enableDdcSupport = false;
      };
      colorSchemes = {
        useWallpaperColors = false;
        predefinedScheme = "Noctalia (default)";
        darkMode = true;
        schedulingMode = "off";
        manualSunrise = "06:30";
        manualSunset = "21:30";
        matugenSchemeType = "scheme-fruit-salad";
      };
      templates = {
        activeTemplates = [];
        enableUserTemplates = false;
      };
      nightLight = {
        enabled = false;
        forced = false;
        autoSchedule = true;
        nightTemp = "4000";
        dayTemp = "6500";
        manualSunrise = "06:30";
        manualSunset = "18:30";
      };
      hooks = {
        enabled = false;
        wallpaperChange = "";
        darkModeChange = "";
        screenLock = "";
        screenUnlock = "";
        performanceModeEnabled = "";
        performanceModeDisabled = "";
      };
      desktopWidgets = {
        enabled = false;
        gridSnap = false;
        monitorWidgets = [];
      };
    };
  };
}
