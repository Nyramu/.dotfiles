{ self, ... }:

let
  stylixCfg = pkgs: host: {
    base16Scheme = {
      base00 = "#1a1210"; # Default Background - deep dark brown-black
      base01 = "#2a1c14"; # Lighter Background - dark burnt brown
      base02 = "#5a3a28"; # Selection Background - dark chocolate-brown
      base03 = "#a07e66"; # Comments, Invisibles - muted brown
      base04 = "#b98864"; # Dark Foreground - medium brown
      base05 = "#d88860"; # Default Foreground - warm terracotta
      base06 = "#f0a878"; # Light Foreground - light coral-orange
      base07 = "#ffc898"; # Light Background - pale peach-orange

      base08 = "#ff5410"; # Variables, Deleted - orange flame
      base09 = "#ff6000"; # Integers, Constants - vivid orange-red
      base0A = "#ff8c20"; # Classes, Bold - bright orange
      base0B = "#ffa030"; # Strings, Inserted - amber solar corona
      base0C = "#ff6c18"; # Support, Regex - mid orange flame
      base0D = "#dd3010"; # Functions, Headings - clear dark red
      base0E = "#ff7020"; # Keywords, Italic - scorched orange-red
      base0F = "#4e0e04"; # Deprecated - charred near-black
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
