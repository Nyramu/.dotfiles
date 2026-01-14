{ pkgs }:

rec
{
  system = "base16";
  name = "Theme Name";
  author = "https://github.com/Nyramu";
  polarity = "dark";

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
    terminal = 0.63;
    applications = 0.6;
    desktop = 0.7;
    popups = 0.7;
  };

  palette = {
    base00 = "#eeeeee"; # Default Background -
    base01 = "#eeeeee"; # Lighter Background - 
    base02 = "#eeeeee"; # Selection Background - 
    base03 = "#eeeeee"; # Comments, Invisibles - 
    base04 = "#eeeeee"; # Dark Foreground - 
    base05 = "#eeeeee"; # Default Foreground - 
    base06 = "#eeeeee"; # Light Foreground - 
    base07 = "#eeeeee"; # Light Background - 

    base08 = "#eeeeee"; # Variables, Deleted - 
    base09 = "#eeeeee"; # Integers, Constants - 
    base0A = "#eeeeee"; # Classes, Bold - 
    base0B = "#eeeeee"; # Strings, Inserted - 
    base0C = "#eeeeee"; # Support, Regex - 
    base0D = "#eeeeee"; # Functions, Headings - 
    base0E = "#eeeeee"; # Keywords, Italic - 
    base0F = "#eeeeee"; # Deprecated - 
  };

  # Hyprland color configuration
  hypr = {
    active_border_color = "rgb(eeeeee) rgb(eeeeee) rgb(eeeeee) 270deg";
    inactive_border_color = "rgb(eeeeee)";
    locked_group_active_border_color = "rgb(eeeeee) rgb(eeeeee) rgb(eeeeee) 270deg"; # Picked from wallpaper
    
    text_color = "rgb(eeeeee)"; # palette.base07
    inactive_text_color = "rgb(eeeeee)"; # palette.base04
    locked_group_active_text_color = "rgb(eeeeee)"; # Picked from wallpaper, lighter than locked active border

    active_color = "rgb(eeeeee)"; # Last color from active border
    inactive_color = "rgb(eeeeee)"; # Color from inactive border
    locked_group_active_color = "rgb(eeeeee)"; # Last color from locked active border
  };

  # Waybar color configuration
  waybar = {
    background-color = "rgba(38, 38, 38, 0.6)";
    font = fonts.monospace.name;
    font-size = "15";
  };
  
  # Vicinae configuration
  vicinae = {
    font = {
      normal = {
        size = 10.5;
        normal = fonts.monospace.name;
      };
    };
  };

  # SilentSDDM configuration
  silentSDDM = {
    avatar-shape = "square"; # Or "circle"
  };
}
