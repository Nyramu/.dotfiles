{ lib, ... }: with lib;

{
  options.nyra.theme = {
    enable = mkEnableOption "Enable theming";
    defaultTheme = mkOption {
      type = types.enum [ "just-chill" "red-eclipse" "apocalypse" ];
      default = "just-chill";
      description = "Choose a theme: just-chill, red-eclipse, apocalypse";
    };
  };
}
