{ pkgs }:

let
  neospleen-font = pkgs.callPackage ../../nyra/custom-derivations/neospleen-nerd-font.nix {};
in

rec
{
  system = "base16";
  name = "Apocalypse";
  author = "https://github.com/Nyramu";
  polarity = "dark";

  background = ../wallpapers/apocalypse.jpg;

  fonts = {
    serif = {
      package = neospleen-font;
      name = "NeoSpleen Nerd Font";
    }; 
    sansSerif = {
      package = neospleen-font;
      name = "NeoSpleen Nerd Font";
    };
    monospace = {
      package = neospleen-font;
      name = "NeoSpleen Nerd Font Mono";
    };
    emoji = {
      package = pkgs.nerd-fonts.symbols-only;
      name = "Symbols Nerd Font Mono";
    };
    sizes = {
      applications = 15;
      desktop = 10;
      popups = 10;
      terminal = 15;
    };
  };

  opacity = {
    terminal = 0.63;
    applications = 0.6;
    desktop = 0.7;
    popups = 0.7;
  };

  palette = {
    base00 = "#1a1210"; # Default Background - deep dark brown-black
    base01 = "#2a1c14"; # Lighter Background - dark burnt brown
    base02 = "#3a2618"; # Selection Background - dark chocolate-brown
    base03 = "#a07e66"; # Comments, Invisibles - muted brown
    base04 = "#6a4830"; # Dark Foreground - medium brown
    base05 = "#d88860"; # Default Foreground - warm terracotta
    base06 = "#f0a878"; # Light Foreground - light coral-orange
    base07 = "#ffc898"; # Light Background - pale peach-orange

    base08 = "#ff5830"; # Variables, Deleted - bright red-orange
    base09 = "#ff6838"; # Integers, Constants - vibrant red-orange
    base0A = "#ff5830"; # Classes, Bold - warm orange-red
    base0B = "#ff6238"; # Strings, Inserted - bright golden orange
    base0C = "#ff6840"; # Support, Regex - coral-orange
    base0D = "#e13820"; # Functions, Headings - deep red-orange
    base0E = "#c84018"; # Keywords, Italic - dark red-orange
    base0F = "#a83010"; # Deprecated - deep burnt red
  };

  # Hyprland color configuration
  hypr = {
    active_border_color = "rgb(1a1210) rgb(2a1e18) rgb(ed6830) 220deg";
    inactive_border_color = "rgb(3a2618)";
  };

  # Waybar configuration
  waybar = {
    background-color = "rgba(42, 28, 20, 0.6)";
    font = fonts.sansSerif.name;
    font-size = "20";
  };

  # Vicinae configuration
  vicinae = {
    font = {
      normal = {
        size = 13.0;
        normal = fonts.sansSerif.name;
      };
    };
  };

  # SilentSDDM configuration
  silentSDDM = {
    avatar-shape = "circle";
  };
}
