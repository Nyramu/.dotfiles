{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

let
  theme = import config.nyra.theme.path { inherit pkgs; };
  nyraSettings = config.nyra.settings;
  ipc = "noctalia-shell ipc call";
  cfg = config.nyra.desktops;
in
{
  imports = [
    inputs.noctalia.homeModules.default
    ./bar.nix
    ./panels.nix
    ./desktop.nix
    ./region.nix
    ./plugins.nix
  ];

  programs.noctalia-shell = {
    enable = cfg.hyprland.enable;
    settings = {
      general = {
        avatarImage = nyraSettings.pfp;
        radiusRatio = 0.5;
        iRadiusRatio = 0.6;
        enableShadows = true;
        enableBlurBehind = true;
        lockScreenAnimations = true;
        enableLockScreenMediaControls = true;
        compactLockScreen = true;
        lockScreenTint = 0.25;
        lockScreenBlur = 0;
        autoStartAuth = true;
        allowPasswordWithFprintd = true;
        lockOnSuspend = false;
        showSessionButtonsOnLockScreen = false;
        showChangelogOnStartup = true;
        shadowDirection = "bottom";
        shadowOffsetX = 0;
        shadowOffsetY = 3;
        animationSpeed = 1.2;
        animationDisabled = false;
        telemetryEnabled = true;
        clockStyle = "digital";
        clockFormat = "hh:mm";
      };

      ui = {
        fontDefaultScale = theme.noctalia.ui.fontDefaultScale or 1;
        fontFixedScale = theme.noctalia.ui.fontFixedScale or 1;
        panelsAttachedToBar = true;
        scrollbarAlwaysVisible = true;
        settingsPanelMode = "attached";
        settingsPanelSideBarCardStyle = false;
        boxBorderEnabled = true;
        tooltipsEnabled = false;
        translucentWidgets = true;
      };

      network = {
        wifiEnabled = true;
        wifiDetailsViewMode = "list";
        airplaneModeEnabled = false;
        bluetoothDetailsViewMode = "grid";
        bluetoothRssiPollingEnabled = true;
        bluetoothRssiPollIntervalMs = 60000;
        bluetoothHideUnnamedDevices = true;
        disableDiscoverability = false;
      };

      audio = {
        cavaFrameRate = 60;
        visualizerType = "mirrored";
        volumeOverdrive = true;
        mprisBlacklist = [
          "Mozilla zen"
          "Telegram Desktop"
        ];
        preferredPlayer = "Spotify";
      };

      idle = {
        enabled = false;
        screenOffTimeout = 300;
        lockTimeout = 0;
        suspendTimeout = 0;
        fadeDuration = 5;
        customCommands = [ ];
      };

      noctaliaPerformance = {
        disableWallpaper = true;
        disableDesktopWidgets = true;
      };

      hooks = {
        enabled = true;
        wallpaperChange = "";
        darkModeChange = "";
        screenLock = "";
        screenUnlock = "";
        performanceModeEnabled = "";
        performanceModeDisabled = "";
        startup = "${ipc} notifications enableDND; ${ipc} notifications dismissAll";
        session = "";
        colorGeneration = "";
      };
    };

    colors = lib.mkIf (config.stylix.enable) {
      mPrimary = lib.mkIf (theme ? noctalia.colors.mPrimary) (lib.mkForce theme.noctalia.colors.mPrimary);
      mSecondary = lib.mkIf (theme ? noctalia.colors.mSecondary) (
        lib.mkForce theme.noctalia.colors.mSecondary
      );
      mTertiary = lib.mkIf (theme ? noctalia.colors.mTertiary) (
        lib.mkForce theme.noctalia.colors.mTertiary
      );
      mOutline = lib.mkIf (theme ? noctalia.colors.mOutline) (lib.mkForce theme.noctalia.colors.mOutline);
      mHover = lib.mkIf (theme ? noctalia.colors.mHover) (lib.mkForce theme.noctalia.colors.mHover);
      mOnHover = lib.mkIf (theme ? noctalia.colors.mOnHover) (lib.mkForce theme.noctalia.colors.mOnHover);
    };
  };
}
