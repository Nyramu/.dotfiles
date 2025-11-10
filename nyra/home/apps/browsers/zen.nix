{ inputs, config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.home.apps.browsers;
in
{
  imports = [ inputs.zen-browser.homeModules.default ];

  options.nyra.home.apps.browsers = {
    zen.enable = mkOption {
      type = types.bool;
      default = cfg.default == "zen";
      description = "Enable Zen Browser";
    };
  };

  config = {
    programs.zen-browser = {
      enable = cfg.zen.enable;
      policies = let
        mkLockedAttrs = builtins.mapAttrs (_: value: {
          Value = value;
          Status = "locked";
        });
      in {
        AppAutoUpdate = false;
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        Preferences = mkLockedAttrs {
          "browser.tabs.warnOnClose" = false;
        };
      };
      profiles.nyramu = {
        containersForce = true;
        containers = {
          Personal = {
            color = "purple";
            icon = "fingerprint";
            id = 1;
          };
          Work = {
            color = "blue";
            icon = "briefcase";
            id = 2;
          };
          Shopping = {
            color = "yellow";
            icon = "dollar";
            id = 3;
          };
        };
      };
      profiles.nyramu.extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          ublock-origin
          refined-github
          dearrow
          return-youtube-dislikes
          protondb-for-steam
          #proton-pass
      ];
    };
  };
}
