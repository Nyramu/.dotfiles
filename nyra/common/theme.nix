{ config, lib, ... }:

{
  options.nyra.theme = {
    enable = lib.mkEnableOption "Enable theming";
    name = lib.mkOption {
      type = lib.types.enum [
        "just-chill"
        "red-eclipse"
        "apocalypse"
        "greenpath"
        "gruvbox-dark"
      ];
      default = "just-chill";
      description = "Choose a theme from resources/themes folder";
    };
    path = lib.mkOption {
      type = lib.types.path;
      description = "Path to theme";
    };
  };

  config.nyra.theme = {
    # You don't want to touch this
    path = lib.mkDefault ../../resources/themes/${config.nyra.theme.name}.nix;
  };
}
