{
  inputs,
  config,
  lib,
  ...
}:

let
  cfg = config.nyra.apps.browsers;
  nyraSettings = config.nyra.settings;
in
{
  imports = [
    inputs.zen-browser.homeModules.twilight
    ./policies.nix
    ./extensions.nix
    ./bookmarks.nix
    ./search.nix
    ./mods.nix
  ];

  options.nyra.apps.browsers.zen = {
    enable = lib.mkEnableOption "zen browser";
  };

  config = {
    nyra.apps.browsers.zen.enable = lib.mkDefault (cfg.default == "zen-twilight");
    programs.zen-browser = {
      enable = cfg.zen.enable;
      profiles.${nyraSettings.username} = {
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
          "zen.urlbar.behavior" = "floating-on-type";
          "zen.urlbar.hide-one-offs" = false;
          "zen.urlbar.replace-newtab" = false;
          "zen.urlbar.show-domain-only-in-sidebar" = false;

          # Compact mode
          "zen.view.compact.enable-at-startup" = false;
          "zen.view.compact.hide-tabbar" = false;
          "zen.view.compact.hide-toolbar" = true;
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
          "zen.theme.acrylic-elements" = true;
          "zen.view.hide-window-controls" = false;
          "zen.view.show-newtab-button-top" = false;
          "zen.view.use-single-toolbar" = true;
          "zen.view.window.scheme" = 0;
          "zen.welcome-screen.seen" = true;
          "zen.widget.linux.transparency" = false;
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
