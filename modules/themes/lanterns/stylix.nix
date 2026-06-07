{ ... }:

let
  stylixCfg = pkgs: {
    base16Scheme = {
      base00 = "#1a2a32"; # Default Background - deep teal black
      base01 = "#243038"; # Lighter Background - dark teal shadow
      base02 = "#3a5263"; # Selection Background - night teal blue
      base03 = "#4a6272"; # Comments, Invisibles - muted blue slate
      base04 = "#587480"; # Dark Foreground - weathered teal stone
      base05 = "#98bcc4"; # Default Foreground - pale water mist
      base06 = "#b8d4da"; # Light Foreground - moonlit surface
      base07 = "#d0e8ee"; # Bright Foreground - clear dusk sky

      base08 = "#cc3028"; # Variables, Errors - pure lantern red
      base09 = "#d47820"; # Integers, Constants - lantern flame orange
      base0A = "#607898"; # Classes, Search - mountain slope twilight
      base0B = "#c04060"; # Strings, Success - crimson water reflection
      base0C = "#4a80a0"; # Support, Regex - shadowed river teal
      base0D = "#6aaab8"; # Functions, Links - dusk sky azure
      base0E = "#a03060"; # Keywords, Storage - deep wine foliage
      base0F = "#7a2828"; # Deprecated, Diff Delete - deep shadow crimson
    };

    image = pkgs.fetchurl {
      url = "https://r4.wallpaperflare.com/wallpaper/535/803/707/aenami-digital-art-artwork-illustration-painting-hd-wallpaper-e866edc84050fc5880ac518e2852446a.jpg";
      hash = "sha256-QmrJseARV+VWQUUy+6kC1HClK89ze9pS7N05rjpXpSk=";
    };

    opacity = {
      terminal = 0.66;  
    };
    
    fonts = {
      serif = {
        package = pkgs.nerd-fonts.code-new-roman;
        name = "CodeNewRoman Nerd Font";
      };
      sansSerif = {
        package = pkgs.nerd-fonts.code-new-roman;
        name = "CodeNewRoman Nerd Font";
      };
      monospace = {
        package = pkgs.nerd-fonts.code-new-roman;
        name = "CodeNewRoman Nerd Font Mono";
      };
      sizes = {
        applications = 13.5;
        desktop = 12.5;
        popups = 12.5;
        terminal = 13.5;
      };
    };
  };
in
{
  flake.modules.homeManager = {
    theme-lanterns =
      { pkgs, ... }:
      {
        stylix = (stylixCfg pkgs);
      };
  };

  flake.modules.nixos = {
    theme-lanterns =
      { pkgs, ... }:
      {
        stylix = (stylixCfg pkgs);
      };
  };
}
