{
  config,
  lib,
  pkgs,
  ...
}:

let
  screenShot = pkgs.callPackage ../../nyra/commands/screen-shot { };
  screenRecord = pkgs.callPackage ../../nyra/commands/screen-record { };
  nyraSettings = config.nyra.settings;
in
{
  imports = [
    ../../nyra/home
    ../../nyra/commands/nyra
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  home = {
    username = nyraSettings.username;
    homeDirectory = "/home/${nyraSettings.username}";
    stateVersion = "26.05";
    packages = [
      screenShot
      screenRecord
    ];
  };
  news.display = "silent";

  programs.home-manager.enable = true;

  # XDG configuration
  xdg =
    let
      xdg = import ./xdg.nix { inherit config lib pkgs; };
    in
    {
      enable = true;
      desktopEntries = xdg.desktopEntries;
      mimeApps = {
        enable = true;
        defaultApplications = xdg.defaultApplications;
      };
    };
}
