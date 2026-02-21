{ config, lib, ... }:

{
  options.nyra.theme = {
    enable = lib.mkEnableOption "Enable theming";
    name = lib.mkOption {
      type = lib.types.enum [
        "just-chill"
        "red-eclipse"
        "apocalypse"
      ];
      default = "just-chill";
      description = "Choose a theme: just-chill, red-eclipse, apocalypse";
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
