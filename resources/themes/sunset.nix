{ pkgs }:

{
  system = "base16";
  name = "Sunset";
  author = "https://github.com/Nyramu";
  polarity = "dark";

  background = pkgs.fetchurl {
    url = "https://r4.wallpaperflare.com/wallpaper/342/168/1015/waneella-pixel-art-city-sunset-hd-wallpaper-b40612242749e2adddac705dda8a0e2a.jpg";
    hash = "sha256-xAz9egVTCnrM2gqU6T3lMVwA3lt2B4abOySq0Pd9/FM="; 
  };
  
  fonts = {
    serif = {
      package = pkgs.monocraft;
      name = "Monocraft Nerd Font";
    };
    sansSerif = {
      package = pkgs.monocraft;
      name = "Monocraft Nerd Font";
    };
    monospace = {
      package = pkgs.pixel-code;
      name = "Pixel Code";
    };
  }; 

  opacity = {
    terminal = 0.6;
    applications = 0.6;
    desktop = 0.7;
    popups = 0.7;
  };

  palette = {
    base00 = "262626"; # Default Background
    base01 = "152522"; # Lighter Background (selection)
    base02 = "000000"; # Selection Background (normal black)
    base03 = "909090"; # Comments, Invisibles, Line Highlighting (bright black)
    base04 = "ffb0b4"; # Dark Foreground (selection text)
    base05 = "ffb0b4"; # Default Foreground
    base06 = "ffb0b4"; # Light Foreground (normal white)
    base07 = "ffffff"; # Light Background (bright white)

    base08 = "ff5555"; # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted (normal red)
    base09 = "e4725f"; # Integers, Boolean, Constants, XML Attributes, Markup Link Url (normal yellow/cyan)
    base0A = "fa696e"; # Classes, Markup Bold, Search Text Background (normal green)
    base0B = "fa696e"; # Strings, Inherited Class, Markup Code, Diff Inserted (normal green)
    base0C = "e4725f"; # Support, Regular Expressions, Escape Characters, Markup Quotes (normal cyan)
    base0D = "bc5453"; # Functions, Methods, Attribute IDs, Headings (normal blue)
    base0E = "cf1e13"; # Keywords, Storage, Selector, Markup Italic, Diff Changed (normal magenta)
    base0F = "cf1e13"; # Deprecated, Opening/Closing Embedded Language Tags (normal magenta)
  };

  # Hyprland color configuration
  hypr = {
    active_border_color = "rgb(542624) rgb(d66e65)";
    inactive_border_color = "rgb(152927)"; 
  };
}
