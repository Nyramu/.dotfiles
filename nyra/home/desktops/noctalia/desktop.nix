{
  config,
  lib,
  ...
}:

let
  nyraSettings = config.nyra.settings;
  cfg = config.nyra.desktops;
in
{
  programs.noctalia-shell = {
    enable = cfg.hyprland.enable;
    settings = {
      wallpaper = {
        enabled = true;
        overviewEnabled = false;
        directory = "${nyraSettings.dotfiles}/resources/wallpapers";
        monitorDirectories = [ ];
        showHiddenFiles = false;
        viewMode = "single";
        setWallpaperOnAllMonitors = true;
        linkLightAndDarkWallpapers = true;
        fillMode = "crop";
        useSolidColor = false;
        automationEnabled = false;
        wallpaperChangeMode = "random";
        randomIntervalSec = 300;
        transitionDuration = 1000;
        transitionType = [ "disc" ];
        skipStartupTransition = false;
        transitionEdgeSmoothness = 0;
        panelPosition = "follow_bar";
        hideWallpaperFilenames = false;
        useOriginalImages = false;
        useWallhaven = false;
        sortOrder = "name";
        favorites = [ ];
      };

      notifications = {
        enabled = true;
        enableMarkdown = true;
        clearDismissed = true;
        density = "compact";
        location = "bottom_right";
        overlayLayer = true;
        backgroundOpacity = lib.mkForce 0.8;
        respectExpireTimeout = true;
        lowUrgencyDuration = 3;
        normalUrgencyDuration = 3;
        criticalUrgencyDuration = 3;
        enableKeyboardLayoutToast = false;
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

      dock.enabled = false;
      desktopWidgets.enabled = false;
      sounds.enabled = false;
    };
  };
}
