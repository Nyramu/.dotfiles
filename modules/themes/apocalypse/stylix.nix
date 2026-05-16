{ self, ... }:

let
  stylixCfg = pkgs: host: {
    base16Scheme = {
      base00 = "#1a1210"; # Default Background - deep dark brown-black
      base01 = "#2a1c14"; # Lighter Background - dark burnt brown
      base02 = "#3a2618"; # Selection Background - dark chocolate-brown
      base03 = "#a07e66"; # Comments, Invisibles - muted brown
      base04 = "#b98864"; # Dark Foreground - medium brown
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

    image = ./wallpaper.jpg;

    fonts = with self.packages.${host.system}; {
      serif = {
        package = nerd-fonts-neospleen;
        name = "NeoSpleen Nerd Font";
      };
      sansSerif = {
        package = nerd-fonts-neospleen;
        name = "NeoSpleen Nerd Font";
      };
      monospace = {
        package = nerd-fonts-neospleen;
        name = "NeoSpleen Nerd Font"; # Or NeoSpleen Nerd Font Mono
      };
      sizes = {
        applications = 14;
        desktop = 10;
        popups = 10;
        terminal = 13.5;
      };
    };
  };
in
{
  flake.modules.homeManager = {
    theme-apocalypse =
      { pkgs, host, ... }:
      {
        stylix = (stylixCfg pkgs host);
      };
  };

  flake.modules.nixos = {
    theme-apocalypse =
      { pkgs, host, ... }:
      {
        stylix = (stylixCfg pkgs host);
      };
  };
}
