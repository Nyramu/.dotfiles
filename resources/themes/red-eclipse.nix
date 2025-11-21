{ pkgs }:

{
  system = "base16";
  name = "Red Eclipse";
  author = "https://github.com/Nyramu";
  polarity = "dark";

  background = pkgs.fetchurl {
    url = "https://r4.wallpaperflare.com/wallpaper/175/524/956/digital-digital-art-artwork-fantasy-art-drawing-hd-wallpaper-d8562dc820d0acd8506c415eb8e2a49a.jpg";
    hash = "sha256-//C5+xKNN0dcc+kP+2euDx+csul33iBHJcry15XPlJg=";
  };

  fonts = {
    serif = {
      package = pkgs.nerd-fonts._0xproto;
      name = "0xProto Nerd Font";
    }; 
    sansSerif = {
      package = pkgs.nerd-fonts._0xproto;
      name = "0xProto Nerd Font";
    };
    monospace = {
      package = pkgs.nerd-fonts._0xproto;
      name = "0xProto Nerd Font";
    };
    emoji = {
      package = pkgs.nerd-fonts.symbols-only;
      name = "Symbols Nerd Font";
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
    active_border_color = "rgb(1a1625) rgb(b83858) 330deg";
    inactive_border_color = "rgb(1a1625)";
  };

  # Waybar color configuration
  waybar = {
    background-color = "rgba(38, 36, 52, 0.6)";
  };

  # SDDM configuration
  sddm = {
    avatarShape = "circle";
  };
}
