{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

let
  cfg = config.nyra.apps.misc.spicetify;
  spicePkgs = inputs.spicetify.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [ inputs.spicetify.homeManagerModules.spicetify ];

  options.nyra.apps.misc.spicetify = {
    enable = lib.mkEnableOption "spicetify";
  };

  config = lib.mkIf (cfg.enable) {
    programs.spicetify = {
      enable = true;
      wayland = config.nyra.wayland.enable;
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
  };
}
