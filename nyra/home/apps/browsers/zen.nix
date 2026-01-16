{ inputs, config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.home.apps.browsers;

  # Fix for unfree packages not being installed despite being allowed
  firefox-addons = pkgs.callPackage inputs.firefox-addons {
    inherit (pkgs) fetchurl stdenv lib;
  };
in
{
  imports = [ inputs.zen-browser.homeModules.beta ];

  options.nyra.home.apps.browsers = {
    zen.enable = mkOption {
      type = types.bool;
      default = cfg.default == "zen-beta";
      description = "Enable Zen Browser";
    };
  };

  config = {
    programs.zen-browser = {
      enable = cfg.zen.enable;
      profiles.nyramu.bookmarks = {
        force = true;
        settings = [
          {
            name = "NixOS";
            toolbar = false;
            bookmarks = [
              {
                name = "Homepage";
                url = "https://nixos.org/";
              }
              {
                name = "Wiki";
                tags = ["wiki" "nix"];
                url = "https://wiki.nixos.org/";
              }
            ];
          }
          {
            name = "GitHub";
            toolbar = false;
            bookmarks = [
              {
                name = "My stars";
                url = "https://github.com/Nyramu?tab=stars";
              }
              {
                name = "My dotfiles";
                url = "https://github.com/Nyramu/.dotfiles";
              }
            ];
          }
          {
            name = "Configs for my dotfiles";
            toolbar = false;
            bookmarks = [
              {
                name = "Noctalia";
                url = "https://docs.noctalia.dev/getting-started/nixos/";
              }
            ];
          }
        ];
      };
      profiles.nyramu.extensions.packages = with firefox-addons; [
        ublock-origin
        dearrow
        return-youtube-dislikes
        augmented-steam
        protondb-for-steam
        #animalese-typing # Cool and cute but annoying
        betterttv
        censor-tracker
        clearurls
        copy-selection-as-markdown
        #firenvim
        image-search-options
        indie-wiki-buddy
        simplifygmail
        the-camelizer-price-history-ch
        to-google-translate
        tampermonkey
        youtube-no-translation
        youtube-shorts-block
        youtube-nonstop
        darkreader
      ];
      policies = let
        mkLockedAttrs = builtins.mapAttrs (_: value: {
          Value = value;
          Status = "locked";
        });
      in {
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
          Locked= true;
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
        NoDefaultBookmarks = mkDefault true;
        OfferToSaveLogins = false;
        PasswordManagerEnabled = false;
        PictureInPicture = true;
        PopupBlocking = {
          Default = false;
          Locked = true;
        }; 
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
        SearchBar = "unified";
        SearchEngines = {
          Add = [
            {
              Name = "DuckDuckGo";
              URLTemplate = "https://duckduckgo.com/?q={searchTerms}";
              Method = "GET";
              IconURL = "https://duckduckgo.com/favicon.ico";
              Alias = "ddg";
              Description = "DuckDuckGo Search";
              SuggestURLTemplate = "https://duckduckgo.com/ac/?q={searchTerms}&type=list";
            }
            {
              Name = "Brave Search";
              URLTemplate = "https://search.brave.com/search?q={searchTerms}";
              Method = "GET";
              IconURL = "https://brave.com/static-assets/images/brave-favicon.png";
              Alias = "brave";
              Description = "Brave Search";
            }
            {
              Name = "GitHub";
              URLTemplate = "https://github.com/search?q={searchTerms}";
              Method = "GET";
              IconURL = "https://github.com/favicon.ico";
              Alias = "gh";
              Description = "Search GitHub repositories";
            }
            {
              Name = "YouTube";
              URLTemplate = "https://www.youtube.com/results?search_query={searchTerms}";
              Method = "GET";
              IconURL = "https://www.youtube.com/favicon.ico";
              Alias = "yt";
              Description = "Search YouTube videos";
              SuggestURLTemplate = "https://suggestqueries.google.com/complete/search?client=youtube&ds=yt&q={searchTerms}";
            }
            {
              Name = "NixOS Packages";
              URLTemplate = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
              Method = "GET";
              IconURL = "https://nixos.org/favicon.ico";
              Alias = "nixpkgs";
              Description = "Search NixOS packages (unstable)";
            }
            {
              Name = "MyNixOS";
              URLTemplate = "https://mynixos.com/search?q={searchTerms}";
              Method = "GET";
              IconURL = "https://mynixos.com/favicon.ico";
              Alias = "mynix";
              Description = "Search NixOS options and packages";
            } 
          ];
          Remove = [
            "Bing"
            "Ecosia"
            "Google"
            "Perplexity"
            "Qwant"
            "Wikipedia (en)"
          ];
          Default = "DuckDuckGo";
          PreventInstalls = true;
        };
        SearchSuggestEnabled = true;
        ShowHomeButton = true;
        SkipTermsOfUse = true;

      };
      profiles.nyramu = {
        isDefault = true;
        settings = {
          # Sidebar and toolbar
          "zen.tabs.show-newtab-vertical" = true;
          "zen.theme.content-element-separation" = 12;
          "zen.theme.gradient" = false;
          "zen.view.sidebar-expanded" = false;
  
          # Sidebar width
          "zen.view.sidebar-expanded.max-width" = 400;
          "zen.view.sidebar-expanded.min-width" = 250;
  
          # URL bar
          "zen.urlbar.behavior" = "normal";
          "zen.urlbar.hide-one-offs" = false;
          "zen.urlbar.show-domain-only-in-sidebar" = false;
  
          # Compact mode
          "zen.view.compact.enable-at-startup" = false;
          "zen.view.compact.hide-tabbar" = false;
          "zen.view.compact.hide-toolbar" = false;
          "zen.view.compat.show-sidebar-and-toolbar-on-hover" = false;
          "zen.view.compact.toolbar-flash-popup" = false;
 
          # Workspace
          "zen.workspaces.enabled" = true;
          "zen.workspaces.hide-default-container-indicator" = false;
          "zen.workspaces.show-icon-strip" = true;
          "zen.workspaces.individual-pinned-tabs" = true;
          "zen.workspaces.continue-where-left-off" = true;
          "zen.workspaces.hide-deactivated-workspaces" = true;
          "zen.workspaces.per-workspace-history" = true; 
          "zen.workspaces.close-on-last-tab" = false;
          "zen.workspaces.force-container-workspace" = true;

          # Other
          "privacy.userContext.ui.colorize" = false;
          "zen.view.hide-window-controls" = false;
          "zen.view.show-newtab-button-top" = false;
          "zen.view.use-single-toolbar" = true;
          "zen.view.window.scheme" = 0;
          "zen.welcome-screen.seen" = true;
          "zen.widget.linux.transparency" = true;
        };
        containersForce = true;
        containers = {
          Personal = {
            color = "purple";
            icon = "chill";
            id = 1;
          };
          "Work/Study" = {
            color = "turquoise";
            icon = "briefcase";
            id = 2;
          };
          Other = {
            color = "orange";
            icon = "circle";
            id = 3;
          };
        };
      };
    };
  };
}
