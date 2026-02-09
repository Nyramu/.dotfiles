{ pkgs }:

rec {
  system = "base16";
  name = "Just Chill";
  author = "https://github.com/Nyramu";
  polarity = "dark";

  background = pkgs.fetchurl {
    url = "https://r4.wallpaperflare.com/wallpaper/342/168/1015/waneella-pixel-art-city-sunset-hd-wallpaper-b40612242749e2adddac705dda8a0e2a.jpg";
    hash = "sha256-xAz9egVTCnrM2gqU6T3lMVwA3lt2B4abOySq0Pd9/FM=";
  };

  fonts = {
    serif = {
      package = pkgs.monocraft;
      name = "Monocraft";
    };
    sansSerif = {
      package = pkgs.monocraft;
      name = "Monocraft";
    };
    monospace = {
      package = pkgs.pixel-code;
      name = "Pixel Code";
    };
    emoji = {
      package = pkgs.nerd-fonts.symbols-only;
      name = "Symbols Nerd Font";
    };
    sizes = {
      applications = 12;
      desktop = 10;
      popups = 10;
      terminal = 12;
    };
  };

  palette = {
    base00 = "#1a1214"; # Default Background - deep dark burgundy-black
    base01 = "#2a1a1e"; # Lighter Background - dark burgundy-gray
    base02 = "#3a2228"; # Selection Background - dark wine-purple
    base03 = "#707070"; # Comments, Invisibles - medium gray
    base04 = "#aaaaaa"; # Dark Foreground - light gray
    base05 = "#ffb0b4"; # Default Foreground - light pink
    base06 = "#ffc8cc"; # Light Foreground - lighter pink
    base07 = "#ffb0b4"; # Light Background - light pink

    base08 = "#d94856"; # Variables, Deleted - deep burgundy-red
    base09 = "#b83848"; # Integers, Constants - dark wine-red
    base0A = "#fa696e"; # Classes, Bold - coral-pink
    base0B = "#fb7a7f"; # Strings, Inserted - medium burgundy-red
    base0C = "#c84850"; # Support, Regex - medium burgundy-red
    base0D = "#c84048"; # Functions, Headings - muted burgundy
    base0E = "#b84050"; # Keywords, Italic - medium burgundy
    base0F = "#a83848"; # Deprecated - muted burgundy-red
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
      mPrimary = palette.base0A;
      mSecondary = palette.base07;
      mTertiary = palette.base03;
      mOutline = palette.base02;
      mHover = palette.base02;
      mOnHover = palette.base0A;
      control-center-logo = "primary"; # "primary" | "secondary" | "tertiary" | "error"
    };
  };

  # Vicinae configuration
  vicinae.font.normal.normal = fonts.monospace.name;
}
