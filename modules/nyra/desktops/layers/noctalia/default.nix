{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.modules.homeManager = {
    desktops.imports = [ self.modules.homeManager.noctalia ];

    noctalia =
      {
        config,
        performance,
        user,
        ...
      }:

      let
        ipc = "noctalia-shell ipc call";
        cfg = config.nyra.desktops.layers.noctalia;
      in
      {
        imports = [
          inputs.noctalia.homeModules.default
          self.modules.homeManager.hyprland
        ];

        options.nyra.desktops.layers.noctalia = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
            description = "Enable noctalia-shell";
          };
        };

        config = lib.mkIf (cfg.enable) {
          programs.noctalia-shell = {
            enable = true;
            settings = {
              general = {
                avatarImage = user.pfp;
                radiusRatio = 0.5;
                iRadiusRatio = 0.6;
                enableShadows = true;
                enableBlurBehind = if (performance != "potato") then true else false;
                lockScreenAnimations = if (performance != "potato") then true else false;
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
                animationDisabled = if (performance == "potato") then true else false;
                telemetryEnabled = true;
                clockStyle = "digital";
                clockFormat = "hh:mm";
              };

              ui = {
                fontDefaultScale = lib.mkDefault 1;
                fontFixedScale = lib.mkDefault 1;
                panelsAttachedToBar = true;
                scrollbarAlwaysVisible = true;
                settingsPanelMode = "attached";
                settingsPanelSideBarCardStyle = false;
                boxBorderEnabled = true;
                tooltipsEnabled = false;
                translucentWidgets = if (performance != "potato") then true else false;
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
          };

          hyprnix.settings.layer_rule = lib.mkIf (config.nyra.desktops.hyprland.enable) {
            "noctalia-blur" = {
              blur = true;
              blur_popups = true;
              ignore_alpha = 0.5;
              match.namespace = "noctalia-background-.*$";
            };
          };
        };
      };
  };
}
