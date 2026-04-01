{ pkgs }:

let
  neospleen-font = pkgs.callPackage ../../nyra/custom-derivations/neospleen-nerd-font.nix { };
in

rec {
  system = "base16";
  name = "Gruvbox Dark";
  author = "https://github.com/morhetz/gruvbox";
  polarity = "dark";

  background = pkgs.fetchurl {
    url = "https://wallpapercave.com/download/gruvbox-wallpapers-wp11058350";
    hash = "sha256-sBR8i9F7lGmu7bWPKBrN7nFWYtHAss3aVXr0YdhOUjc=";
  };

  fonts = {
    serif = {
      package = neospleen-font;
      name = "NeoSpleen Nerd Font";
    };
    sansSerif = {
      package = neospleen-font;
      name = "NeoSpleen Nerd Font";
    };
    monospace = {
      package = neospleen-font;
      name = "NeoSpleen Nerd Font"; # Or NeoSpleen Nerd Font Mono
    };
    emoji = {
      package = pkgs.nerd-fonts.symbols-only;
      name = "Symbols Nerd Font";
    };
    sizes = {
      applications = 13;
      desktop = 12;
      popups = 12;
      terminal = 13;
    };
  };

  opacity = {
    terminal = 0.77;
  };

  palette = {
    base00 = "#282828"; # Default Background - dark warm charcoal
    base01 = "#1d2021"; # Lighter Background - near-black warm gray
    base02 = "#3c3836"; # Selection Background - warm dark brown-gray
    base03 = "#504945"; # Comments, Invisibles - medium warm brown
    base04 = "#665c54"; # Dark Foreground - muted warm tan
    base05 = "#ebdbb2"; # Default Foreground - warm cream
    base06 = "#d5c4a1"; # Light Foreground - muted warm beige
    base07 = "#fbf1c7"; # Light Background - pale warm yellow-white
    base08 = "#fb4934"; # Variables, Deleted - vivid warm red
    base09 = "#fe8019"; # Integers, Constants - bright orange
    base0A = "#fabd2f"; # Classes, Bold - golden yellow
    base0B = "#b8bb26"; # Strings, Inserted - olive green
    base0C = "#8ec07c"; # Support, Regex - soft aqua-green
    base0D = "#83a598"; # Functions, Headings - muted teal-blue
    base0E = "#d3869b"; # Keywords, Italic - dusty mauve-pink
    base0F = "#d65d0e"; # Deprecated - burnt orange
  };

  # Hyprland color configuration
  hypr = {
    active_border_color = "rgb(542624) rgb(d66e65) rgb(fa696e) 270deg";
    inactive_border_color = "rgb(152927)";
    locked_group_active_border_color = "rgb(13160d) rgb(274044) rgb(90b7b2) 270deg"; # Picked from wallpaper

    text_color = "rgb(ffb0b4)"; # palette.base07
    inactive_text_color = "rgb(909090)"; # palette.base04
    locked_group_active_text_color = "rgb(b9f9e1)"; # Picked from wallpaper, lighter than locked active border

    active_color = "rgb(fa696e)"; # Last color from active border
    inactive_color = "rgb(152927)"; # Color from inactive border
    locked_group_active_color = "rgb(90b7b2)"; # Last color from locked active border
  };

  # Noctalia configuration
  noctalia = {
    colors = {
      mPrimary = "#b8bb26";
      mSecondary = "#fabd2f";
      mTertiary = "#83a598";
      mOutline = "#57514e";
      mHover = "#83a598";
      mOnHover = "#282828";
      control-center-logo = "primary"; # "primary" | "secondary" | "tertiary" | "error"
    };
    ui = {
      fontDefaultScale = 1.25;
      fontFixedScale = 1.25;
    };
  };

  # Vicinae configuration
  vicinae = {
    ui.opacity = 0.83;
    font.normal.size = 13.5;
  };
}
