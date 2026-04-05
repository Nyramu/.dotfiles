{
  config,
  pkgs,
  ...
}:

let
  theme = import config.nyra.theme.path { inherit pkgs; };
in
{
  programs.noctalia-shell = {
    settings = {
      bar = {
        barType = "simple";
        position = "top";
        monitors = [ ];
        density = "spacious";
        capsuleColorKey = "none";
        showOutline = false;
        showCapsule = false;
        useSeparateOpacity = false;
        contentPadding = 2;
        widgetSpacing = 0;
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
        showOnWorkspaceSwitch = false;
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
              focusedColor = theme.noctalia.workspace.focusedColor or "primary";
              occupiedColor = theme.noctalia.workspace.occupiedColor or "secondary";
              emptyColor = theme.noctalia.workspace.emptyColor or "tertiary";
              enableScrollWheel = true;
              followFocusedScreen = true;
              groupedBorderOpacity = 0;
              fontWeight = theme.noctalia.workspace.fontWeight or "medium";
              hideUnoccupied = true;
              iconScale = 0.75;
              pillSize = 0.67;
              id = "Workspace";
              labelMode = "index";
              showBadge = true;
              showApplications = true;
              showApplicationsHover = true;
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
                "steam"
                "Telegram Desktop"
                "spotify-client"
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
              hideWhenIdle = true;
              id = "MediaMini";
              maxWidth = 600;
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
            {
              id = "plugin:usb-drive-manager";
            }
            {
              compactMode = false;
              diskPath = "/";
              iconColor = "primary";
              id = "SystemMonitor";
              showCpuCores = false;
              showCpuFreq = false;
              showCpuTemp = true;
              showCpuUsage = false;
              showDiskAvailable = false;
              showDiskUsage = false;
              showDiskUsageAsPercent = false;
              showGpuTemp = false;
              showLoadAverage = false;
              showMemoryAsPercent = false;
              showMemoryUsage = false;
              showNetworkStats = false;
              showSwapUsage = false;
              textColor = "secondary";
              useMonospaceFont = true;
              usePadding = false;
            }
            {
              displayMode = "alwaysShow";
              id = "Volume";
              middleClickCommand = "pwvucontrol || pavucontrol";
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
              id = "Clock";
              tooltipFormat = "dddd, dd/MM/yyyy";
              useCustomFont = false;
              clockColor = theme.noctalia.clock.color or "primary";
            }
          ];
        };
        mouseWheelAction = "workspace";
        reverseScroll = false;
        mouseWheelWrap = true;
        middleClickAction = "settings";
        middleClickFollowMouse = true;
        middleClickCommand = "";
        rightClickAction = "controlCenter";
        rightClickFollowMouse = true;
        rightClickCommand = "";
      };
    };
  };
}
