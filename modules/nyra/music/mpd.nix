{ self, lib, ... }:
{
  flake.modules.homeManager = {
    music.imports = [ self.modules.homeManager.mpd ];

    mpd =
      {
        config,
        audio,
        pkgs,
        ...
      }:

      let
        cfg = config.nyra.music.mpd;
        dirs = config.xdg.userDirs;
      in
      {
        options.nyra.music.mpd = {
          enable = lib.mkEnableOption "mpd";
        };

        config = lib.mkIf (cfg.enable) {
          services.mpd = {
            enable = true;
            musicDirectory = "${dirs.music}";
            playlistDirectory = "${dirs.extraConfig.PLAYLISTS}";
            extraConfig =
              if (audio == "pipewire") then
                ''
                  audio_output {
                    type       "pipewire"
                    name       "PipeWire"
                    mixer_type "software"
                    always_on  "yes"
                  }

                  auto_update "yes"
                ''
              else if (audio == "pulseaudio") then
                ''
                  audio_output {
                    type       "pulse"
                    name       "PulseAudio"
                    mixer_type "software"
                  }
                ''
              else
                "";
          };
          services.mpd-mpris.enable = true;

          programs.cava = lib.mkIf (audio != null) {
            enable = true;
            settings = {
              input = {
                method = if (audio == "pulseaudio") then "pulse" else audio;
                source = "auto";
              };
            };
          };

          home.packages = [ pkgs.mpc ];

          home.sessionVariables = {
            XDG_MUSIC_DIR = dirs.music;
            XDG_LYRICS_DIR = dirs.extraConfig.LYRICS;
            XDG_PLAYLISTS_DIR = dirs.extraConfig.PLAYLISTS;
          };

          xdg.userDirs = {
            music = "${config.home.homeDirectory}/Music";
            extraConfig = {
              LYRICS = "${dirs.music}/Lyrics";
              PLAYLISTS = "${dirs.music}/Playlists";
            };
          };
        };
      };
  };
}
