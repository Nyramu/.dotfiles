{ lib, ... }: with lib;

{
  options.nyra.theme = {
    enable = mkEnableOption "Enable theme";
    defaultTheme = mkOption {
      type = types.enum [ "pixel-sunset" ];
      default = "pixel-sunset";
      description = "Choose a theme: pixel-sunset";
    };
  };
}
