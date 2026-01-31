{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

let
  cfg = config.nyra.home.apps.spicetify;
  spicePkgs = inputs.spicetify.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [ inputs.spicetify.homeManagerModules.spicetify ];

  options.nyra.home.apps.spicetify = {
    enable = lib.mkEnableOption "spicetify";
  };

  config.programs.spicetify = {
    enable = cfg.enable;
    wayland = true;
    windowManagerPatch = true;
    enabledCustomApps = with spicePkgs.apps; [
      newReleases
      marketplace
      ncsVisualizer
    ];
    enabledExtensions = with spicePkgs.extensions; [
      autoSkipVideo
      autoVolume
      adblockify
      fullAppDisplay
      hidePodcasts
      showQueueDuration
      betterGenres
      savePlaylists
      volumePercentage
      beautifulLyrics
      aiBandBlocker
    ];
  };
}
