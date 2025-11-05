{ config, lib, ... }: with lib;

let
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
        tabs.tabs_are_windows = true;
      };
      searchEngines = {
        duck = "https://www.duckduckgo.com/?q={}";
        nixosWiki = "https://wiki.nixos.org/index.php?search={}";
      };
    };
  };
}
