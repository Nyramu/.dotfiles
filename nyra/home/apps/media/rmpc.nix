{ config, lib, ... }: with lib;

let
  cfg = config.nyra.home.apps.media;
in
{
  options.nyra.home.apps.media = {
    rmpc.enable = mkEnableOption "rmpc";
  };

  config = {
    services.mpd = {
      enable = cfg.rmpc.enable;
      musicDirectory = "${config.home.homeDirectory}/Music";
      playlistDirectory = "${config.home.homeDirectory}/Music/Playlists";
      extraConfig = ''
        audio_output {
          type       "pipewire"
          name       "PipeWire"
          mixer_type "software"
        }

        audio_output {
          type    "fifo"
          name    "Visualizer"
          path    "/tmp/mpd.fifo"
          format  "44100:16:2"
        }
      '';

      # Pulseaudio
      #extraConfig = ''
      #  audio_output {
      #    type       "pulse"
      #    name       "PulseAudio"
      #    mixer_type "software"
      #  }
      #'';
    };
    programs.cava = {
      enable = cfg.rmpc.enable;
    };
    programs.rmpc = {
      enable = cfg.rmpc.enable;
      config = ''
        #![enable(implicit_some)]
        #![enable(unwrap_newtypes)]
        #![enable(unwrap_variant_newtypes)]
        (
          lyrics_dir: Some("${config.home.homeDirectory}/Music/Lyrics"),
          rewind_to_start_sec: Some(90),
          password: None,
          theme: None,
          cache_dir: None,
          on_song_change: None,
          volume_step: 5,
          max_fps: 60,
          wrap_navigation: true,
          enable_mouse: true,
          enable_config_hot_reload: true,
          status_update_interval_ms: Some(1000),
          directories_sort: SortFormat(group_by_type: true, reverse: false),
          browser_song_sort: [Artist, Track, Title],
          artists: (
            album_display_mode: SplitByDate,
            album_sort_by: Name,
            album_date_tags: OriginalDate,
          ),
          cava: (
            bar_symbols: ['▁', '▂', '▃', '▄', '▅', '▆', '▇', '█'],
            inverted_bar_symbols: ['▔', '🮂', '🮃', '▀', '🮄', '🮅', '🮆', '█'],
            bar_width: 1,
            bar_spacing: 1,
            orientation: Bottom,
            input: (
              method: Fifo,
              source: "/tmp/mpd.fifo",
              sample_rate: Some(44100),
              channels: Some(2),
              sample_bits: Some(16),
            ),
            smoothing: (
              monstercat: true,
              waves: false,
            ),
          ),
          tabs: [
             (
              name: "Queue",
              pane: Split(
                direction: Horizontal,
                panes: [
                  (size: "40%", pane: Pane(AlbumArt)),
                  (size: "60%", pane: Split(
                    direction: Vertical,
                    panes: [
                      (size: "40%", pane: Pane(Queue)),
                      (size: "30%", pane: Pane(Lyrics)),
                      (size: "30%", pane: Pane(Cava)),
                    ],
                  )),
                ],
              ),
            ),
            (
              name: "Directories",
              pane: Pane(Directories),
            ),
            (
              name: "Playlists",
              pane: Pane(Playlists),
            ),
            (
              name: "Search",
              pane: Pane(Search),
            ),
          ],
        )
      '';
    };
  };
}

