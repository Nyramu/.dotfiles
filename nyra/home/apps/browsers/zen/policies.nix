{ lib, ... }:

{
  programs.zen-browser = {
    policies =
      let
        mkLockedAttrs = builtins.mapAttrs (
          _: value: {
            Value = value;
            Status = "locked";
          }
        );
      in
      {
        AppAutoUpdate = false;
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        Cookies = {
          Behavior = "reject-tracker-and-partition-foreign";
          BehaviorPrivateBrowsing = "reject-tracker-and-partition-foreign";
          Locked = true;
        };
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxAccounts = false;
        DisableFirefoxScreenshots = true;
        DisableFirefoxStudies = true;
        DisablePasswordReveal = true;
        DisablePocket = true;
        DisableProfileImport = true;
        DisableSafeMode = false;
        DisableSetDesktopBackground = true;
        DisableTelemetry = true;
        DisplayBookmarksToolbar = "never";
        DisplayMenuBar = "always";
        DNSOverHTTPS = {
          Enabled = true;
          ProviderURL = "https://cloudflare-dns.com/dns-query";
          Locked = true;
        };
        DontCheckDefaultBrowser = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
          EmailTracking = true;
          SuspectedFingerprinting = true;
          Category = "strict";
          BaselineExceptions = true;
        };
        ExtensionSettings = {
          "*" = {
            installation_mode = "force_installed";
            #default_area = "navbar";
            temporarily_allow_weak_signatures = false;
            private_browsing = true;
          };
        };
        FirefoxHome = {
          Search = true;
          TopSites = false;
          SponsoredTopSites = false;
          Highlights = true;
          Pocket = false;
          Stories = false;
          SponsoredPocket = false;
          SponsoredStories = false;
          Snippets = true;
          Locked = true;
        };
        FirefoxSuggest = {
          WebSuggestions = true;
          SponsoredSuggestions = false;
          ImproveSuggest = true;
          Locked = true;
        };
        GenerativeAI = {
          Enabled = false;
          Chatbot = false;
          TabGroups = false;
          Locked = true;
        };
        HardwareAcceleration = true;
        Homepage = {
          Locked = true;
          StartPage = "previous-session";
        };
        HttpsOnlyMode = "force_enabled";
        ManualAppUpdateOnly = true;
        NoDefaultBookmarks = lib.mkDefault true;
        OfferToSaveLogins = false;
        PasswordManagerEnabled = false;
        PictureInPicture = true;
        PopupBlocking = {
          Default = false;
          Locked = true;
        };
        SearchSuggestEnabled = true;
        ShowHomeButton = true;
        SkipTermsOfUse = true;
        SearchBar = "unified";
        Preferences = mkLockedAttrs {
          "browser.aboutConfig.showWarning" = false;
          "browser.aboutwelcome.enabled" = false;
          "browser.ipProtection.enabled" = true; # Experimental
          "browser.ipProtection.variant" = "treatment";
          "browser.tabs.allow_transparent_browser" = true;
          "browser.tabs.warnOnOpen" = false;
          "browser.tabs.warnOnClose" = false;
          "browser.taskbarTabs.enabled" = false;
          "browser.vpn_promo.enabled" = false;
          "extensions.autoDisableScopes" = 0;
          "widget.transparent-windows" = true;

          "privacy.resistFingerprinting" = true;
          "privacy.resistFingerprinting.randomization.canvas.use_siphash" = true;
          "privacy.resistFingerprinting.randomization.daily_reset.enabled" = true;
          "privacy.resistFingerprinting.randomization.daily_reset.private.enabled" = true;
          "privacy.resistFingerprinting.block_mozAddonManager" = true;
          "privacy.spoof_english" = 1;
        };
      };
  };
}
