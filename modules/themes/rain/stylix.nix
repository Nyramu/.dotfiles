{ ... }:

let
  stylixCfg = pkgs: dotpkgs: {
    base16Scheme = {
      base00 = "#181819"; # Default Background - rain-soaked night black
      base01 = "#1f1f22"; # Lighter Background - dark stairwell shadow
      base02 = "#292b2e"; # Selection Background - charcoal balcony steel
      base03 = "#5c5f66"; # Comments, Invisibles - muted rain gray
      base04 = "#7a7c83"; # Dark Foreground - weathered concrete gray
      base05 = "#a4a7ac"; # Default Foreground - misted glass pale gray
      base06 = "#cac6bf"; # Light Foreground - warm tatami straw
      base07 = "#eaddbc"; # Bright Foreground - lit wooden floor glow

      base08 = "#a03d3d"; # Variables, Errors - deep signage red
      base09 = "#597a86"; # Integers, Constants - rain-streaked window teal
      base0A = "#c6a25b"; # Classes, Search - dim gold shoe rack wood
      base0B = "#506e4c"; # Strings, Success - balcony plant green
      base0C = "#e7af52"; # Support, Regex - warm interior light
      base0D = "#d8933a"; # Functions, Links - amber room lantern
      base0E = "#7f3642"; # Keywords, Storage - dark crimson character stroke
      base0F = "#362c2b"; # Deprecated, Diff Delete - deepest exterior shadow
    };

    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/2y/wallhaven-2yo6q9.jpg";
      hash = "sha256-YmRH2NCpsWe0SPycPj9QeRI9Ian+v51sPCHknOKSkUk=";
    };

    opacity = {
      terminal = 0.7;
    };

    fonts = with dotpkgs; {
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
    theme-rain =
      { pkgs, dotpkgs, ... }:
      {
        stylix = (stylixCfg pkgs dotpkgs);
      };
  };

  flake.modules.nixos = {
    theme-rain =
      { pkgs, dotpkgs, ... }:
      {
        stylix = (stylixCfg pkgs dotpkgs);
      };
  };
}
