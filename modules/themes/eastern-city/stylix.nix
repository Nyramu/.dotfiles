{ ... }:

let
  stylixCfg = pkgs: {
    base16Scheme = {
      base00 = "#1a1214"; # Default Background - deep wine black
      base01 = "#24181b"; # Lighter Background
      base02 = "#6a5458"; # Selection Background - elevated wine rose
      base03 = "#8a666b"; # Comments, Invisibles - lifted dusty rose
      base04 = "#b0898d"; # Dark Foreground - muted pink beige
      base05 = "#e6b8bc"; # Default Foreground - soft rose
      base06 = "#f0c8cb"; # Light Foreground - pale coral pink
      base07 = "#f4b7ba"; # Bright Foreground - warm sakura

      base08 = "#fa696e"; # Variables, Errors - lantern coral
      base09 = "#ff9b71"; # Integers, Constants - sunset orange
      base0A = "#e7a27e"; # Classes, Search - muted sunset peach
      base0B = "#ff8f88"; # Strings, Success - soft coral
      base0C = "#ffb0b4"; # Support, Regex - signature pink
      base0D = "#7cb2ae"; # Functions, Links - softened wallpaper cyan
      base0E = "#ea968f"; # Keywords, Storage - soft salmon rose
      base0F = "#b85a63"; # Deprecated, Diff Delete - wine red
    };

    image = pkgs.fetchurl {
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
      sizes = {
        terminal = 11.5;
      };
    };
  };
in
{
  flake.modules.homeManager = {
    theme-eastern-city =
      { pkgs, ... }:
      {
        stylix = (stylixCfg pkgs);
      };
  };

  flake.modules.nixos = {
    theme-eastern-city =
      { pkgs, ... }:
      {
        stylix = (stylixCfg pkgs);
      };
  };
}
