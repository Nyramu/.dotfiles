{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

let
  theme = import ../../../resources/themes/${config.nyra.theme.name}.nix { inherit pkgs; };
  cfg = config.nyra.desktops;
in
{
  imports = [ inputs.vicinae.homeManagerModules.default ];

  services.vicinae = {
    enable = cfg.hyprland.enable;
    systemd.enable = true;
    settings = {
      close_on_focus_loss = false;
      consider_preedit = false;
      pop_to_root_on_close = true;
      favicon_service = "twenty";
      search_files_in_root = true;
      escape_key_behavior = "navigate_back";
      launcher_window = {
        opacity = lib.mkIf (theme ? vicinae.ui.opacity) (lib.mkForce theme.vicinae.ui.opacity);
        layer_shell = {
          enabled = true;
          keyboard_interactivity = "on_demand";
          layer = "top";
        };
        size = {
          width = 900;
          height = 561;
        };
        client_side_decorations.enabled = true;
      };
      font = {
        normal = {
          size = theme.vicinae.font.normal.size or 10.5;
          normal = lib.mkIf (theme ? vicinae.font.normal.normal) theme.vicinae.font.normal.normal;
        };
      };
      favorites = [
        # "clipboard:history"
        "@mattisssa/spotify-player:yourLibrary"
        "@leonkohli/vicinae-extension-process-manager-0:processes"
        "@Costeer/vicinae-extension-color-converter-0:convert-color"
      ];
      keybinds = {
        "toggle-action-panel" = "control+return";
        "action.duplicate" = "control+t";
        "action.dangerous-remove" = "control+shift+d";
        "action.remove" = "control+d";
      };
      fallbacks = [];
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
            sponsor.enabled = false;
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
        "@mattisssa/spotify-player" = {
          entrypoints = {
            search = {
              preferences = {
                musicOnly = true;
                topView = "tracks";
              };
            };
            yourLibrary = {
              preferences = {
                Default-View = "playlists";
              };
            };
            devices.enabled = false;
            generatePlaylist.enabled = false;
            next.enabled = false;
            previous.enabled = false;
            togglePlayPause.enabled = false;
            nowPlaying.enabled = true;
            findLyrics.enabled = false;
            toggleShuffle.enabled = true;
          };
        };
        files = {
          enabled = false;
          # preferences = {
          #   autoIndexing = false;
          # };
        };
        system = {
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
        wm.enabled = false;
      };
    };
    extensions =
      with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system};
      with inputs.vicinae.packages.${pkgs.stdenv.hostPlatform.system};
      [
        color-converter
        process-manager
        (mkRayCastExtension {
          name = "spotify-player";
          rev = "485fb0acf5701f8e1aec3f632726a4d2ccfb7256";
          hash = "sha256-VZInT6zhp19/hgpzBVmWAOvkTaM7T0sZSSmpvhOvCkc=";
        })
      ];
  };
}
