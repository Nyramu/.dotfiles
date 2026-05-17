{ ... }:

let
  stylixCfg = pkgs: host: {
    base16Scheme = {
      base00 = "#0d0c18"; # Default Background - deep night blue/black
      base01 = "#1a1625"; # Lighter Background - dark purple-blue
      base02 = "#2a1f35"; # Selection Background - medium dark purple
      base03 = "#4f3e5e"; # Comments, Invisibles - muted purple
      base04 = "#7e6878"; # Dark Foreground - lighter muted purple
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

    image = ./wallpaper.jpg;
  };
in
{
  flake.modules.homeManager = {
    theme-red-eclipse =
      { pkgs, host, ... }:
      {
        stylix = (stylixCfg pkgs host);
      };
  };

  flake.modules.nixos = {
    theme-red-eclipse =
      { pkgs, host, ... }:
      {
        stylix = (stylixCfg pkgs host);
      };
  };
}
