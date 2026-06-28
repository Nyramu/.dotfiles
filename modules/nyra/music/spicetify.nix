{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.modules.homeManager = {
    music.imports = [ self.modules.homeManager.spicetify ];

    spicetify =
      {
        config,
        wayland,
        host,
        ...
      }:

      let
        cfg = config.nyra.music.spicetify;
        spicePkgs = inputs.spicetify.legacyPackages.${host.system};
      in
      {
        imports = [ inputs.spicetify.homeManagerModules.spicetify ];

        options.nyra.music.spicetify = {
          enable = lib.mkEnableOption "spicetify";
        };

        config = lib.mkIf (cfg.enable) {
          programs.spicetify = {
            enable = true;
            wayland = wayland.enable;
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
      };
  };
}
