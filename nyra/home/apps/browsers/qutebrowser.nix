{ config, lib, ... }: with lib;

let
  themeName = config.nyra.theme.defaultTheme;
  theme = import ../../../../resources/themes/${themeName}.nix { inherit pkgs; };
  cfg = config.nyra.home.apps.browsers;
in
{
  options.nyra.home.apps.browsers = {
    qutebrowser.enable = mkOption {
      type = types.bool;
      default = cfg.default == "qutebrowser";
      description = "Enable qutebrowser";
    };
  };

  config = {
    programs.qutebrowser = {
      enable = cfg.qutebrowser.enable;

      settings = {
        auto_save.session = true;
        confirm_quit = [ "downloads" ];
        tabs.show = "multiple";
        tabs.tabs_are_windows = false;
        tabs.select_on_remove = "prev";
        tabs.title.format = "{audio}{current_title}";
        url.default_page = "https://github.com/Nyramu";
        window.transparent = true;
        content = { 
          blocking.enabled = true;
          cookies.accept = "no-3rdparty";
          geolocation = false;
          headers.do_not_track = true;
        };
        input.insert_mode.auto_load = true;
      };

      settings.colors = {
        webpage.darkmode.enabled = theme.polarity == "dark";
        webpage.bg = mkForce "#${theme.palette.base00}";
        # Transparent tabs, stylix cannot apply its opacity here
        tabs.even.bg = mkForce "#00000066";
        tabs.odd.bg = mkForce "#00000066";
        tabs.bar.bg = mkForce "#00000066";
        # Black tabs
        tabs.selected.even.bg = mkForce "#${theme.palette.base00}";
        tabs.selected.odd.bg = mkForce "#${theme.palette.base00}"; 
      }; 

      searchEngines = {
        duck = "https://www.duckduckgo.com/?q={}";
        nixpkgs = "https://search.nixos.org/packages?channel=unstable&query={}";
        mynix = "https://mynixos.com/search?q={}";
        yt = "https://www.youtube.com/results?search_query={}";
        gh = "https://github.com/search?o=desc&q={}&s=stars";
      };

    };
  };
}
