{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

let
  theme = import ../../resources/themes/${config.nyra.theme.defaultTheme}.nix { inherit pkgs; };
in
{
  imports = [
    inputs.stylix.nixosModules.stylix
    ./apps
    ./hardware
    ./desktops
    ./services
    ../common
  ];

  options.nyra.system = {
    fonts = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
    };
  };

  # "fc-list : family | sort | uniq" to list
  config = {
    nyra.system.fonts = lib.mkIf (config.nyra.theme.enable) [
      theme.fonts.serif.package
      theme.fonts.sansSerif.package
      theme.fonts.monospace.package
      theme.fonts.emoji.package
    ];
    fonts.packages = config.nyra.system.fonts;
    fonts.enableDefaultPackages = true;
  };
}
