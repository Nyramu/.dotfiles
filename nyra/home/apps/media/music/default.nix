{ config, lib, pkgs, ... }: with lib;

let
  rmpc-theme = import ./rmpc-theme.nix { inherit config pkgs; };
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

        auto_update "yes"
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
    #services.mpd-mpris.enable = config.services.mpd.enable;
    #services.mpdris2.enable = config.services.mpd.enable;
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
          theme: Some("theme.ron"),
          cache_dir: None,
          on_song_change: None,
          volume_step: 5,
          max_fps: 60,
          wrap_navigation: true,
          enable_mouse: true,
          enable_config_hot_reload: true,
          status_update_interval_ms: Some(125),
          directories_sort: SortFormat(group_by_type: true, reverse: false),
          browser_song_sort: [Artist, Track, Title],
          artists: (
            album_display_mode: SplitByDate,
            album_sort_by: Name,
            album_date_tags: [OriginalDate],
          ),
          cava: (
            bar_symbols: ['▁', '▂', '▃', '▄', '▅', '▆', '▇', '█'],
            inverted_bar_symbols: ['▔', '🮂', '🮃', '▀', '🮄', '🮅', '🮆', '█'],
            bar_width: 1,
            bar_spacing: 1,
            orientation: Top,
            input: (
              method: Fifo,
              source: "/tmp/mpd.fifo",
              sample_rate: Some(44100),
              channels: Some(2),
              sample_bits: Some(16),
            ),
            smoothing: (
              monstercat: false,
              waves: true,
            ),
          ),
          tabs: [
            (
              name: " Queue",
              pane: Split(
                direction: Vertical,
                panes: [
                  (size: "70%", pane: Split(
                    direction: Horizontal,
                    panes: [
                      (size: "50%", pane: Split(
                        borders: "NONE",
                        direction: Vertical,
                        panes: [
                          (size: "60%", pane: Pane(Queue), borders: "BOTTOM | RIGHT"),
                          (size: "40%", pane: Pane(Lyrics), borders: "TOP | BOTTOM | RIGHT"),
                        ],
                      )),
                      (size: "50%", pane: Split(
                        direction: Horizontal,
                        panes: [
                          (size: "100%", pane: Pane(AlbumArt)),
                        ],
                      )),
                    ],
                  )),
                  (size: "30%", pane: Pane(Cava)),
                ],
              ),
            ),
            (
              name: " Lyrics",
              pane: Split(
                direction: Horizontal,
                panes: [
                  (size: "32%", pane: Pane(Property(
                    content: [(kind: Text(""))]
                  ))),
                  (size: "36%", pane: Split(
                    direction: Vertical,
                    panes: [
                      (size: "37%", pane: Pane(AlbumArt)),
                      (size: "15%", pane: Split(
                        borders: "TOP | BOTTOM",
                        direction: Vertical,
                        panes: [
                          (size: "60%", pane: Pane(Property(
                            content: [
                              (kind: Property(Song(Title)), style: (modifiers:"Bold"))
                            ],
                            align: Center
                          ))),
                          (size: "40%", pane: Pane(Property(
                            content: [
                              (kind: Property(Song(Artist)))
                            ],
                            align: Center
                          ))),
                        ],
                      )), 
                      (size: "48%", pane: Pane(Lyrics)),
                    ],
                  )),
                  (size: "32%", pane: Pane(Property(
                    content: [(kind: Text(""))]
                  ))),
                ],
              ),
            ),
            (
              name: " Playlists",
              pane: Pane(Playlists),
            ),
            (
              name: " Directories",
              pane: Pane(Directories),
            ),
            (
              name: " Search",
              pane: Pane(Search),
            ),
          ],
          keybinds: (
            global: {
              ":":       CommandMode,
              ",":       VolumeDown,
              "s":       Stop,
              ".":       VolumeUp,
              "<Tab>":   NextTab,
              "<S-Tab>": PreviousTab,
              "1":       SwitchToTab(" Queue"),
              "2":       SwitchToTab(" Lyrics"),
              "3":       SwitchToTab(" Playlists"),
              "4":       SwitchToTab(" Directories"),
              "5":       SwitchToTab(" Search"),
              "q":       Quit,
              ">":       NextTrack,
              "p":       TogglePause,
              "<":       PreviousTrack,
              "f":       SeekForward,
              "z":       ToggleRandom,
              "x":       ToggleRepeat,
              "c":       ToggleSingle,
              "v":       ToggleConsume,
              "b":       SeekBack,
              "~":       ShowHelp,
              "u":       Update,
              "U":       Rescan,
              "I":       ShowCurrentSongInfo,
              "O":       ShowOutputs,
              "P":       ShowDecoders,
              "R":       AddRandom,
            },
            navigation: {
              "<Up>":      Up,
              "<Down>":    Down,
              "<Left>":    Left,
              "<Right>":   Right,
              "<C-k>":     PaneUp,
              "<C-j>":     PaneDown,
              "<C-h>":     PaneLeft,
              "<C-l>":     PaneRight,
              "<C-u>":     UpHalf,
              "N":         PreviousResult,
              "a":         Add,
              "A":         AddAll,
              "r":         Rename,
              "n":         NextResult,
              "g":         Top,
              "<Space>":   Select,
              "<C-Space>": InvertSelection,
              "G":         Bottom,
              "<CR>":      Confirm,
              "i":         FocusInput,
              "J":         MoveDown,
              "<C-d>":     DownHalf,
              "/":         EnterSearch,
              "<C-c>":     Close,
              "<Esc>":     Close,
              "K":         MoveUp,
              "D":         Delete,
              "B":         ShowInfo,
              "<C-z>":     ContextMenu(),
              "<C-s>":     Save(kind: Modal(all: false, duplicates_strategy: Ask)),
            },
            queue: {
              "D":       DeleteAll,
              "<CR>":    Play,
              "a":       AddToPlaylist,
              "d":       Delete,
              "C":       JumpToCurrent,
              "X":       Shuffle,
            },
          ),
          search: (
            case_sensitive: false,
            ignore_diacritics: false,
            search_button: false,
            mode: Contains,
            tags: [
              (value: "any",         label: "Any Tag"),
              (value: "artist",      label: "Artist"),
              (value: "album",       label: "Album"),
              (value: "albumartist", label: "Album Artist"),
              (value: "title",       label: "Title"),
              (value: "filename",    label: "Filename"),
              (value: "genre",       label: "Genre"),
            ],
          ),
        )
      '';
    };
    xdg.configFile."rmpc/theme.ron".text = rmpc-theme;
  };
}

