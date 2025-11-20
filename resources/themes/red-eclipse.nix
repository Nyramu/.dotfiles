{ pkgs }:

{
  system = "base16";
  name = "Red Eclipse";
  author = "https://github.com/Nyramu";
  polarity = "dark";

  background = pkgs.fetchurl {
    url = "https://r4.wallpaperflare.com/wallpaper/175/524/956/digital-digital-art-artwork-fantasy-art-drawing-hd-wallpaper-d8562dc820d0acd8506c415eb8e2a49a.jpg";
    hash = "";
  };

  fonts = {
    serif = monospace;
    sansSerif = monospace;
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
    terminal = 0.6;
    applications = 0.6;
    desktop = 0.7;
    popups = 0.7;
  };

  palette = {
    base00 = "0a0a14"; # Default Background - deep night blue/black
    base01 = "1a1828"; # Lighter Background - dark purple-blue
    base02 = "2d1f3a"; # Selection Background - medium dark purple
    base03 = "4a3550"; # Comments, Invisibles - muted purple
    base04 = "b89aa8"; # Dark Foreground - medium mauve-grey
    base05 = "e6c8d4"; # Default Foreground - pale rose
    base06 = "f5e0ea"; # Light Foreground - very pale pink
    base07 = "fef5f8"; # Light Background - almost white

    base08 = "ff2818"; # Variables, Deleted - intense bright red from eclipse
    base09 = "d92820"; # Integers, Constants - deep vivid red
    base0A = "b82428"; # Classes, Bold - dark crimson red
    base0B = "8f1e28"; # Strings, Inserted - dark wine red
    base0C = "ff4830"; # Support, Regex - bright red-orange
    base0D = "ff6040"; # Functions, Headings - coral-red
    base0E = "c83830"; # Keywords, Italic - medium dark red
    base0F = "a02828"; # Deprecated - deep burgundy red
  };

  # Hyprland color configuration
  hypr = {
    active_border_color = "rgb(1a1828) rgb(b82428)";
    inactive_border_color = "rgb(1a1828)";
    decoration.shadow.color = "rgba(1a1a1aee)";
  };

  # Waybar color configuration
  waybar = {
    background-color = "rgba(38, 36, 52, 0.6)";
  };
}
