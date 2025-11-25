{ config, lib, pkgs, ... }: with lib;

let
  themeCfg = config.nyra.theme;
  theme = import ../../../resources/themes/${themeCfg.defaultTheme}.nix { inherit pkgs; };
  fontsCfg = config.nyra.system.fonts;
in
{
  options.nyra.system = {
    fonts = mkOption {
      type = types.listOf types.package;
      default = [];
    };
  };
  # "fc-list : family | sort | uniq" to list
  config = mkMerge [
    {
      fonts.packages = fontsCfg;
      fonts.enableDefaultPackages = true;
    }
    (mkIf themeCfg.enable {
      nyra.system.fonts = [
        theme.fonts.serif.package
        theme.fonts.sansSerif.package
        theme.fonts.monospace.package
      ];
    })
  ];
}
