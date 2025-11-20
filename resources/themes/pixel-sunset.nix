{ pkgs }:

{
  system = "base16";
  name = "Pixel Sunset";
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
    emoji = {
      package = pkgs.nerd-fonts.symbols-only;
      name = "Symbols Nerd Font";
    };
  }; 

  opacity = {
    terminal = 0.6;
    applications = 0.6;
    desktop = 0.7;
    popups = 0.7;
  };

  palette = {
    base00 = "#262626"; # Default Background - dark gray
    base01 = "#152522"; # Lighter Background - dark teal-gray
    base02 = "#000000"; # Selection Background - pure black
    base03 = "#909090"; # Comments, Invisibles - medium gray
    base04 = "#ffb0b4"; # Selection Text - light pink
    base05 = "#ffb0b4"; # Default Foreground - light pink
    base06 = "#ffb0b4"; # Light Foreground - light pink
    base07 = "#ffffff"; # Light Background - pure white

    base08 = "#ff5555"; # Variables, Deleted - bright red
    base09 = "#c14860"; # Integers, Constants - deep rose
    base0A = "#fa696e"; # Classes, Bold - coral pink
    base0B = "#fa696e"; # Strings, Inserted - coral pink
    base0C = "#c14860"; # Support, Regex - deep rose
    base0D = "#fe522e"; # Functions, Headings - orange-red
    base0E = "#c41d0e"; # Keywords, Italic - dark red
    base0F = "#ae1630"; # Deprecated - crimson
  };

  # Hyprland color configuration
  hypr = {
    active_border_color = "rgb(542624) rgb(d66e65) 270deg";
    inactive_border_color = "rgb(152927)";
  };

  # Waybar color configuration
  waybar = {
    background-color = "rgba(38, 38, 38, 0.6)";
  };

  # SDDM configuration
  sddm = {
    avatarShape = "square";
  };
}
