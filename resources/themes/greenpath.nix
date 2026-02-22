{ pkgs }:

rec {
  system = "base16";
  name = "Greenpath";
  author = "https://github.com/Nyramu";
  polarity = "dark";

  background = pkgs.fetchurl {
    url = "https://wallpaperaccess.com/full/5341037.jpg";
    hash = "sha256-QN1P2NcmLWIk++xziWptFrbHSbu+VkJ/8AvO4p4qBEA=";
  };

  fonts = {
    serif = {
      package = pkgs.nerd-fonts.tinos;
      name = "Tinos Nerd Font Propo";
    };
    sansSerif = {
      package = pkgs.nerd-fonts.tinos;
      name = "Tinos Nerd Font Propo";
    };
    monospace = {
      package = pkgs.nerd-fonts.lekton;
      name = "Lekton Nerd Font Mono";
    };
    emoji = {
      package = pkgs.nerd-fonts.symbols-only;
      name = "Symbols Nerd Font";
    };
    sizes = {
      applications = 14;
      desktop = 14;
      popups = 10;
      terminal = 14;
    };
  };

  palette = {
    base00 = "#070d0f"; # Default Background - near-black blue-green
    base01 = "#0d1a1f"; # Lighter Background - dark blue-green
    base02 = "#142830"; # Selection Background - dark teal-blue
    base03 = "#4a7a5a"; # Comments, Invisibles - medium muted green
    base04 = "#4a7a8c"; # Dark Foreground - medium blue-gray
    base05 = "#a0c4d4"; # Default Foreground - pale blue-gray
    base06 = "#a0c4d4"; # Light Foreground - light blue-white
    base07 = "#b0d0de"; # Light Background - near-white blue

    base08 = "#f0e870"; # Variables, Deleted - soft bright yellow
    base09 = "#fdf78b"; # Integers, Constants - pale glow yellow
    base0A = "#40c880"; # Classes, Bold - muted green
    base0B = "#60d4a0"; # Strings, Inserted - soft mint green
    base0C = "#30a890"; # Support, Regex - teal green
    base0D = "#6090b8"; # Functions, Headings - medium blue
    base0E = "#4a70a0"; # Keywords, Italic - dark steel blue
    base0F = "#a0b8c8"; # Deprecated - pale blue-gray
  };

  # Hyprland color configuration
  hypr = {
    active_border_color = "rgb(60d4a0) rgb(4a7a5a) rgb(142830) 245deg";
    inactive_border_color = "rgb(0d1a1f)";
    locked_group_active_border_color = "rgb(4a7a5a) rgb(142830) rgb(a0c4d4) 245deg";

    text_color = "rgb(f0e870)"; # palette.base08
    inactive_text_color = "rgb(4a7a8c)"; # palette.base04
    locked_group_active_text_color = "rgb(b9f9e1)"; # Picked from wallpaper, lighter than locked active border

    active_color = "rgb(142830)"; # Last color from active border
    inactive_color = "rgb(0d1a1f)"; # Color from inactive border
    locked_group_active_color = "rgb(a0c4d4)"; # Last color from locked active border
  };

  # Noctalia configuration
  noctalia = {
    clock = {
      color = "error";
    };
    workspace = {
      focusedColor = "secondary";
      occupiedColor = "primary";
      emptyColor = "tertiary";
    };
    ui = {
      fontDefaultScale = 1.22;
      fontFixedScale = 1.10;
    };
    colors = {
      mPrimary = palette.base03;
      mSecondary = palette.base0B;
      mTertiary = palette.base04;
      mOutline = palette.base02;
      mHover = palette.base02;
      mOnHover = palette.base0A;
      control-center-logo = "primary"; # "primary" | "secondary" | "tertiary" | "error"
    };
  };

  # Vicinae configuration
  vicinae = {
    ui.opacity = 0.9;
    font.normal.size = 14;
    font.normal.normal = fonts.monospace.name;
  };

  # SilentSDDM configuration
  silentSDDM = {
    avatar-shape = "circle";
  };
}
