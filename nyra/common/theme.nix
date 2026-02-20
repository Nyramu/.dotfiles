{ lib, ... }:

{
  options.nyra.theme = rec {
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
      default = ../../resources/themes/${name}.nix;
      description = "Path to theme";
    };
  };
}
