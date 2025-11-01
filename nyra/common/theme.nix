{ lib, ... }: with lib;

{
  options.nyra.theme = {
    enable = mkEnableOption "Enable theme";
    defaultTheme = mkOption {
      type = types.enum [ "sunset" ];
      default = "sunset";
      description = "Choose a theme: sunset";
    };
  };
}
