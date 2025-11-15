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
  draw_borders: true,
  browser_column_widths: [20, 30, 60],
  symbols: (song: "󰎈 ",dir: "󰉋 ",marker: " ",ellipsis: "..."),
  
  tab_bar: (
      enabled: true,
      active_style: (bg: "#${theme.palette.base05}", fg: "#${theme.palette.base00}", modifiers: "Bold"),
      inactive_style: (modifiers: ""),
  ),
  highlighted_item_style: (fg: "#${theme.palette.base0A}", modifiers: "Bold"),
  current_item_style: (bg: "#${theme.palette.base00}", fg: "#${theme.palette.base05}", modifiers: "Bold"),
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
      prop: (kind: Property(Title), style: (),
        highlighted_item_style: (modifiers: "Bold"),
        default: (kind: Property(Filename), style: (),)
      ),
      width: "40%",
    ),
    (
      prop: (kind: Property(Artist), style: (),
        default: (kind: Text("Unknown Artist"), style: ())
      ),
      width: "40%",
    ),
    (
      prop: (kind: Property(Duration), style: ()),
      width: "20%",
      alignment: Right,
    ),
  ],
  header: (
    rows: [
      (
        left: [
          (kind: Property(Status(StateV2(playing_label: " [Playing]", paused_label: " [Paused]", stopped_label: " [Stopped]"))), style: (modifiers: "Bold")),
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
          (kind: Property(Status(StateV2(playing_label: " ❚❚ ", paused_label: "  ", stopped_label: "  "))), style: (modifiers: "Bold")),
          (kind: Property(Status(Elapsed)),style: ()),
          (kind: Text("/"),style: ()),
          (kind: Property(Status(Duration)),style: ()),
        ],
        center: [
          (kind: Property(Song(Artist)), style: (modifiers: "Bold"),
            default: (kind: Text("No song playing"), style: (modifiers: "Bold"))
          ),
        ],
        right: [
          (
            kind: Property(Widget(States(
              active_style: (modifiers: "Bold"),
              separator_style: ()))
            ),
            style: ()
          ),
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
              (size: "4", borders: "ALL", pane: Pane(Header)),
            ]
          )),
        ]
      )),
      (size: "3", pane: Pane(Tabs)),
      (size: "100%", pane: Split(
        direction: Horizontal,
        panes: [
          (size: "100%", borders: "ALL", pane: Pane(TabContent)),
        ]
      )),
    ],
  ),
)
''
