{ config, lib, ... }:

{
  options.nyra.home.apps.music.rmpc = {
    enable = lib.mkEnableOption "rmpc";
  };
  
  config.programs.rmpc = {
    enable = config.nyra.home.apps.music.rmpc.enable;
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
        status_update_interval_ms: Some(1000),
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
                        (size: "60%", pane: Pane(AlbumArt)),
                        (size: "40%", pane: Pane(Lyrics), borders: "TOP | BOTTOM | RIGHT"),
                      ],
                    )),
                    (size: "50%", pane: Split(
                      direction: Horizontal,
                      panes: [
                        (size: "100%", pane: Pane(Queue), borders: "BOTTOM | LEFT"),
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
                    (size: "4", pane: Split(
                      borders: "TOP | BOTTOM",
                      direction: Vertical,
                      panes: [
                        (size: "2", pane: Pane(Property(
                          content: [
                            (kind: Property(Song(Title)), style: (modifiers:"Bold"))
                          ],
                          align: Center
                        ))),
                        (size: "2", pane: Pane(Property(
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
            "?":       ShowHelp,
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
  config.xdg.configFile."rmpc/theme.ron".text = let
    stylix-palette = config.stylix.base16Scheme;
  in ''
    #![enable(implicit_some)]
    #![enable(unwrap_newtypes)]
    #![enable(unwrap_variant_newtypes)]

    (
      default_album_art_path: None,
      show_song_table_header: true,
      draw_borders: false,
      browser_column_widths: [20, 30, 60],
      symbols: (song: " ",dir: " ",marker: " ",ellipsis: "..."),

      tab_bar: (
          enabled: true,
          active_style: (bg: "${stylix-palette.base00}", fg: "${stylix-palette.base0B}", modifiers: "Bold"),
          inactive_style: (modifiers: ""),
      ),
      highlighted_item_style: (fg: "${stylix-palette.base0A}", modifiers: "Bold"),
      current_item_style: (bg: "${stylix-palette.base00}", fg: "${stylix-palette.base0B}", modifiers: "Underlined | Bold"),
      borders_style: (fg: "${stylix-palette.base0A}", modifiers: "Bold"),
      highlight_border_style: (fg: "${stylix-palette.base0A}", modifiers: "Bold"),
      progress_bar: (
          symbols: ["", "█", "", "█", ""],
          track_style: (),
          elapsed_style: (fg: "${stylix-palette.base05}"),
          thumb_style: (fg: "${stylix-palette.base05}"),
      ),
      scrollbar: (
          symbols: ["", "", "", ""],
          track_style: (),
          ends_style: (),
          thumb_style: (),
      ),
      browser_song_format: [
        (
          kind: Group([
            (kind: Property(Track)),
            (kind: Text(" ")),
          ])
        ),
        (
          kind: Group([
            (kind: Property(Title)),
            (kind: Text(" - ")),
            (kind: Property(Artist)),
          ]),
          default: (kind: Property(Filename))
        ),
      ],
      song_table_format: [
        (
          prop: (kind: Property(Artist), style: (),
            default: (kind: Text("Unknown Artist"), style: ())
          ),
          label: " Artist",
          width: "40%",
        ),
        (
          prop: (kind: Property(Title), style: (),
            highlighted_item_style: (modifiers: "Bold"),
            default: (kind: Property(Filename), style: (),)
          ),
          label: "󰦨 Title",
          width: "40%",
        ),
        (
          prop: (kind: Property(Duration), style: ()),
          label: " Time",
          width: "20%",
          alignment: Right,
        ),
      ],
      header: (
        rows: [
          (
            left: [
              (kind: Property(Status(StateV2(playing_label: " [Playing]", paused_label: " [Paused]", stopped_label: " [Stopped]"))), style: (fg: "${stylix-palette.base0B}", modifiers: "Bold")),
            ],
            center: [
              (kind: Property(Song(Title)), style: (modifiers: "Bold"),
                default: (kind: Property(Song(Filename)), style: (modifiers: "Bold"))
              )
            ],
            right: [
              (kind: Text("Volume: "), style: (modifiers: "Bold")),
              (kind: Property(Status(Volume)), style: (modifiers: "Bold")),
              (kind: Text("% "), style: (modifiers: "Bold"))
            ]
          ),
          (
            left: [
              (kind: Property(Status(StateV2(
                playing_label: " ❚❚ ", paused_label: "  ", stopped_label: "  "))),
                style: (fg: "${stylix-palette.base0B}", modifiers: "Bold"
              )),
              (kind: Property(Status(Elapsed)),style: ()),
              (kind: Text("/"),style: ()),
              (kind: Property(Status(Duration)),style: ()),
            ],
            center: [
              (kind: Property(Song(Artist)), style: (modifiers: "Bold"),
                default: (kind: Text("No artist found"), style: (modifiers: "Bold"))
              ),
            ],
            right: [
              (kind: Group([
                (kind: Property(Status(RandomV2(
                  on_label:" ", off_label:" ",
                  on_style: (fg: "${stylix-palette.base05}"), off_style: (fg: "${stylix-palette.base03}"))
                ))),
                (kind: Text(" | "),style: (fg: "${stylix-palette.base0A}")),
                (kind: Property(Status(RepeatV2(
                  on_label:" ", off_label:" ",
                  on_style: (fg: "${stylix-palette.base05}"), off_style: (fg: "${stylix-palette.base03}"))
                ))),
                (kind: Text(" | "),style: (fg: "${stylix-palette.base0A}")),
                (kind: Property(Status(SingleV2(
                  on_label:"󰼏 ", off_label:"󰼏 ", oneshot_label:"󰼏 ",
                  on_style: (fg: "${stylix-palette.base05}"), off_style: (fg: "${stylix-palette.base03}"), oneshot_style: (fg: "${stylix-palette.base0B}"))
                ))),
                (kind: Text(" | "),style: (fg: "${stylix-palette.base0A}")),
                (kind: Property(Status(ConsumeV2(
                  on_label:"  ", off_label:"  ", oneshot_label:"  ",
                  on_style: (fg: "${stylix-palette.base05}"), off_style: (fg: "${stylix-palette.base03}"), oneshot_style: (fg: "${stylix-palette.base0B}"))
                ))),
              ])),
            ]
          ),
        ],
      ),
      layout: Split(
        direction: Vertical,
        panes: [
          (size: "6", pane: Split(
            direction: Horizontal,
            panes: [
              (size: "100%", pane: Split(
                direction: Vertical,
                borders: "ALL",
                panes: [
                  (size: "5", pane: Pane(Header)),
                  (size: "4", pane: Pane(ProgressBar), borders: "TOP"),
                ],
              )),
            ],
          )),

          (size: "3", pane: Pane(Tabs), borders: "ALL"),
          (size: "100%", pane: Split(
            direction: Horizontal,
            panes: [
              (size: "100%", borders: "ALL", pane: Pane(TabContent)),
            ],
          )),
        ],
      ),
      cava: (
        bar_color: Gradient({
          0: "${stylix-palette.base0A}",
          60: "${stylix-palette.base05}",
          100: "${stylix-palette.base05}",
        }),
      ),
    )
  '';
}
