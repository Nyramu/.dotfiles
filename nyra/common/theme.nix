{ lib, ... }: with lib;

{
  options.nyra.theme = {
    enable = mkEnableOption "Enable theme";
    defaultTheme = mkOption {
      type = types.enum [ "pixel-sunset" "red-eclipse" ];
      default = "pixel-sunset";
      description = "Choose a theme: pixel-sunset, red-eclipse";
    };
  };
}
