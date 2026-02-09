{ pkgs }:

rec # Needed to "cross-link" variables (does how I wrote it even make sense? ugh.)
{
  system = "base16";
  name = "Theme Name";
  author = "https://github.com/Nyramu";
  polarity = "dark"; # Or "light", but we don't use flashbangs here

  background = /path/to/background.jpg; # Or a fetchurl

  fonts = {
    serif = {
      package = pkgs.foobar;
      name = "Font Name";
    };
    sansSerif = {
      package = pkgs.foobar;
      name = "Font Name";
    };
    monospace = {
      package = pkgs.foobar;
      name = "Font Name";
    };
    emoji = {
      package = pkgs.foobar;
      name = "Font Name";
    };
    sizes = {
      applications = 12;
      desktop = 10;
      popups = 10;
      terminal = 12;
    };
  };

  opacity = {
    terminal = 0.63; # Default: 0.63
    applications = 0.6; # Default: 0.6
    desktop = 0.7; # Default: 0.7
    popups = 0.7; # Default: 0.7
  };

  palette = {
    base00 = "#eeeeee"; # Default Background - color and tonality
    base01 = "#eeeeee"; # Lighter Background - color and tonality
    base02 = "#eeeeee"; # Selection Background - color and tonality
    base03 = "#eeeeee"; # Comments, Invisibles - color and tonality
    base04 = "#eeeeee"; # Dark Foreground - color and tonality
    base05 = "#eeeeee"; # Default Foreground - color and tonality
    base06 = "#eeeeee"; # Light Foreground - color and tonality
    base07 = "#eeeeee"; # Light Background - color and tonality

    base08 = "#eeeeee"; # Variables, Deleted - color and tonality
    base09 = "#eeeeee"; # Integers, Constants - color and tonality
    base0A = "#eeeeee"; # Classes, Bold - color and tonality
    base0B = "#eeeeee"; # Strings, Inserted - color and tonality
    base0C = "#eeeeee"; # Support, Regex - color and tonality
    base0D = "#eeeeee"; # Functions, Headings - color and tonality
    base0E = "#eeeeee"; # Keywords, Italic - color and tonality
    base0F = "#eeeeee"; # Deprecated - color and tonality
  };

  # Hyprland color configuration
  hypr = {
    active_border_color = "rgb(eeeeee) rgb(eeeeee) rgb(eeeeee) 270deg";
    inactive_border_color = "rgb(eeeeee)";
    locked_group_active_border_color = "rgb(eeeeee) rgb(eeeeee) rgb(eeeeee) 270deg"; # Tip: Pick from wallpaper

    text_color = "rgb(eeeeee)";
    inactive_text_color = "rgb(eeeeee)";
    locked_group_active_text_color = "rgb(eeeeee)"; # Tip: Lighter than locked active border

    active_color = "rgb(eeeeee)"; # Tip: Last color from active border
    inactive_color = "rgb(eeeeee)"; # Tip: Color from inactive border
    locked_group_active_color = "rgb(eeeeee)"; # Tip: Last color from locked active border
  };

  # Noctalia configuration
  noctalia = {
    ui = {
      fontDefaultScale = 1; # Must be between 0.75 and 1.25
      fontFixedScale = 1; # Must be between 0.75 and 1.25
      analogClockInCalendar = false; # Default: true
    };
    colors = {
      mPrimary = palette.base0A; # Or some hex code
      mSecondary = palette.base07; # Same here
      mTertiary = palette.base03; # And here
      mOutline = palette.base02; # And here
      mHover = palette.base02; # Also here
      mOnHover = palette.base0A; # And even here
      control-center-logo = "primary"; # "primary" | "secondary" | "tertiary" | "error"
    };
  };

  # Vicinae configuration
  vicinae = {
    ui = {
      opacity = 0.80; # Ideally between 0.1 and 1.0
    };
    font = {
      normal = {
        size = 10.5; # It's generally better between 10.5 and 12
        normal = fonts.monospace.name; # monospace | sansSerif | serif
      };
    };
  };

  # SilentSDDM configuration
  silentSDDM = {
    avatar-shape = "square"; # "square" | "circle"
  };
}
