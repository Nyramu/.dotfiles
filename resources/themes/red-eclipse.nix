{ pkgs }:

rec
{
  system = "base16";
  name = "Red Eclipse";
  author = "https://github.com/Nyramu";
  polarity = "dark";

  background = ../wallpapers/red-eclipse.jpg;

  fonts = {
    serif = {
      package = pkgs.nerd-fonts.bigblue-terminal;
      name = "BigBlueTermPlus Nerd Font";
    }; 
    sansSerif = {
      package = pkgs.nerd-fonts.bigblue-terminal;
      name = "BigBlueTermPlus Nerd Font";
    };
    monospace = {
      package = pkgs.nerd-fonts.bigblue-terminal;
      name = "BigBlueTermPlus Nerd Font";
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

  opacity = {
    terminal = 0.63;
    applications = 0.6;
    desktop = 0.7;
    popups = 0.7;
  };

  palette = {
    base00 = "#0d0c18"; # Default Background - deep night blue/black
    base01 = "#1a1625"; # Lighter Background - dark purple-blue
    base02 = "#2a1f35"; # Selection Background - medium dark purple
    base03 = "#4f3e5e"; # Comments, Invisibles - muted purple
    base04 = "#5a4560"; # Dark Foreground - lighter muted purple
    base05 = "#d4b0c0"; # Default Foreground - lighter mauve-rose
    base06 = "#f0d8e4"; # Light Foreground - light pale rose
    base07 = "#faeaf0"; # Light Background - very pale pink

    base08 = "#d94060"; # Variables, Deleted - burgundy-red from eclipse
    base09 = "#b83858"; # Integers, Constants - deep wine-burgundy
    base0A = "#983050"; # Classes, Bold - dark wine-red
    base0B = "#a84068"; # Strings, Inserted - wine-burgundy
    base0C = "#e85068"; # Support, Regex - bright burgundy-pink
    base0D = "#c84860"; # Functions, Headings - medium burgundy-red
    base0E = "#a84058"; # Keywords, Italic - muted wine-burgundy
    base0F = "#782838"; # Deprecated - deep dark burgundy
  };

  # Hyprland color configuration
  hypr = {
    active_border_color = "rgb(1a1625) rgb(b83858) rgb(983050) 330deg";
    inactive_border_color = "rgb(1a1625)";
    locked_group_active_border_color = "rgb(1a1625) rgb(5f1d25) rgb(ccb0ad) 270deg"; # Picked from wallpaper

    text_color = "rgb(faeaf0)"; # palette.base07
    inactive_text_color = "rgb(5a4560)"; # palette.base04
    locked_group_active_text_color = "rgb(faeaf0)"; # Picked from wallpaper, lighter than locked active border

    active_color = "rgb(983050)"; # Last color from active border
    inactive_color = "rgb(1a1625)"; # Color from inactive border
    locked_group_active_color = "rgb(ccb0ad)"; # Last color from locked active border
    
  };

  # Vicinae configuration
  vicinae = {
    font = {
      normal = {
        size = 12.0;
        normal = fonts.sansSerif.name;
      };
    };
  };

  # SilentSDDM configuration
  silentSDDM = {
    avatar-shape = "square";
  };
}
