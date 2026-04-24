{ config, ... }:

{
  services.vicinae = {
    settings = {
      providers = {
        applications = {
          entrypoints = {
            auto-cpufreq-gtk.enabled = false;
            cups.enabled = false;
            kvantummanager.enabled = false;
            nixos-manual.enabled = false;
            nvim.enabled = false;
            qt5ct.enabled = false;
            qt6ct.enabled = false;
            rmpc.enabled = false;
            vicinae.enabled = false;
            xterm.enabled = false;
            blueman-manager.enabled = false;
            protontricks.enabled = false;
            helix.enabled = false;
            yazi.enabled = false;
            btop.enabled = false;
          };
        };
        calculator.entrypoints = {
          history.enabled = false;
          refresh-rates.enabled = false;
        };
        clipboard = {
          entrypoints = {
            history = {
              enabled = false;
              alias = ":";
            };
            clear.enabled = false;
            clear-history.enabled = false;
          };
        };
        core = {
          entrypoints = {
            about.enabled = false;
            documentation.enabled = false;
            inspect-local-storage.enabled = false;
            keybind-settings.enabled = false;
            manage-fallback.enabled = false;
            oauth-token-store.enabled = false;
            open-config-file.enabled = false;
            open-default-config.enabled = false;
            prune-memory.enabled = false;
            refresh-apps.enabled = false;
            reload-scripts.enabled = false;
            report-bug.enabled = false;
            search-builtin-icons.enabled = false;
            search-emojis.enabled = false;
            settings.enabled = false;
            sponsor.enabled = false;
          };
        };
        "@Gimblet/vicinae-extension-noctalia-shell-wallpaper-selector-0" = {
          preferences = {
            display_name = "eDP-1";
            wallpaper_directory = "/home/${config.nyra.settings.username}/.dotfiles/resources/wallpapers";
          };
        };
        "@leonkohli/vicinae-extension-process-manager-0" = {
          preferences = {
            clear-search-after-kill = true;
            process-limit = 100;
            refresh-interval = 1000;
            show-path = true;
            show-system-processes = false;
            sort-by-memory = true;
          };
          entrypoints = {
            kill.enabled = false;
          };
        };

        files = {
          enabled = false;
          # preferences = {
          #   autoIndexing = false;
          # };
        };
        system = {
          enabled = false;
          entrypoints = {
            browse-apps.enabled = false;
            run = {
              enabled = false;
              alias = ">";
              preferences = {
                default-action = "run-in-terminal-hold";
              };
            };
          };
        };
        font.enabled = false;
        manage-shortcuts.enabled = false;
        power.enabled = false;
        developer.enabled = false;
        theme.enabled = false;
        browser-extension.enabled = false;
        raycast-compat.enabled = false;
        shortcuts.enabled = false;
        scripts.enabled = false;
        wm.enabled = false;
      };
    };
  };
}
