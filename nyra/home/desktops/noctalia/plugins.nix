{ config, ... }:

{
  programs.noctalia-shell = {
    settings = {
      plugins = {
        autoUpdate = true;
        notifyUpdates = false;
      };
    };

    plugins = {
      sources = [
        {
          enabled = true;
          name = "Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        privacy-indicator = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        weather-indicator = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        usb-drive-manager = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        timer = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
    };

    pluginSettings = {
      privacy-indicator = {
        activeColor = "primary";
        inactiveColor = "tertiary";
        hideInactive = true;
        iconSpacing = 9;
        removeMargins = false;
      };
      usb-drive-manager = {
        autoMount = false;
        fileBrowser = config.nyra.home.apps.defaultFileManager;
        terminalCommand = config.nyra.home.apps.defaultTerminal;
        showNotifications = true;
        hideWhenEmpty = true;
        showBadge = true;
        iconColor = "primary";
      };
      # todo = {
      #   pages = [
      #     {
      #       id = 0;
      #       name = "General";
      #     }
      #     {
      #       id = 1;
      #       name = "Dotfiles";
      #     }
      #   ];
      #   showCompleted = true;
      #   showBackground = false;
      # };
    };
  };
}
