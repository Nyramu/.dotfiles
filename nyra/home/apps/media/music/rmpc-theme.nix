{ config, pkgs, ... }:

let
  themeName = config.nyra.theme.defaultTheme;
  theme = import ../../../../../resources/themes/${themeName}.nix { inherit pkgs; };
in
''
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
      active_style: (bg: "#${theme.palette.base00}", fg: "#${theme.palette.base0A}", modifiers: "Bold"),
      inactive_style: (modifiers: ""),
  ),
  highlighted_item_style: (fg: "#${theme.palette.base0A}", modifiers: "Bold"),
  current_item_style: (bg: "#${theme.palette.base00}", fg: "#${theme.palette.base0A}", modifiers: "Underlined | Bold"),
  borders_style: (fg: "#${theme.palette.base0A}", modifiers: "Bold"),
  highlight_border_style: (fg: "#${theme.palette.base0A}", modifiers: "Bold"),
  progress_bar: (
      symbols: ["┄", "┅", "━"],
      track_style: (),
      elapsed_style: (),
      thumb_style: (),
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
          (kind: Property(Status(StateV2(playing_label: " [Playing]", paused_label: " [Paused]", stopped_label: " [Stopped]"))), style: (fg: "#${theme.palette.base0A}", modifiers: "Bold")),
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
            style: (fg: "#${theme.palette.base0A}", modifiers: "Bold"
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
              on_style: (fg: "#${theme.palette.base05}"), off_style: (fg: "#${theme.palette.base03}"))
            ))),
            (kind: Text(" | "),style: (fg: "#${theme.palette.base0A}")), 
            (kind: Property(Status(RepeatV2(
              on_label:" ", off_label:" ",
              on_style: (fg: "#${theme.palette.base05}"), off_style: (fg: "#${theme.palette.base03}"))
            ))),
            (kind: Text(" | "),style: (fg: "#${theme.palette.base0A}")),
            (kind: Property(Status(SingleV2(
              on_label:"󰼏 ", off_label:"󰼏 ", oneshot_label:"󰼏 ",
              on_style: (fg: "#${theme.palette.base05}"), off_style: (fg: "#${theme.palette.base03}"), oneshot_style: (fg: "#${theme.palette.base0A}"))
            ))),
            (kind: Text(" | "),style: (fg: "#${theme.palette.base0A}")),
            (kind: Property(Status(ConsumeV2(
              on_label:"  ", off_label:"  ", oneshot_label:"  ",
              on_style: (fg: "#${theme.palette.base05}"), off_style: (fg: "#${theme.palette.base03}"), oneshot_style: (fg: "#${theme.palette.base0A}"))
            ))),
          ])),
        ]
      ),
    ],
  ),
  layout: Split(
    direction: Vertical,
    panes: [
      (size: "4", pane: Split(
        direction: Horizontal,
        panes: [
          (size: "100%", pane: Split(
            direction: Vertical,
            panes: [
              (size: "100%", borders: "ALL", pane: Pane(Header)),
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
      0: "#${theme.palette.base0A}",
      60: "#${theme.palette.base05}",
      100: "#${theme.palette.base05}",
    }),
  ),
)
''
