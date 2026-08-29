{ lib, ... }:

{
  flake.modules = {
    homeManager.desktops =
      { config, nyralib, ... }:

      let
        desktop = config.nyra.desktops.default;
      in
      {
        options.nyra.desktops.default = nyralib.mkDefaultOption "DE or WM" ./.;

        config = {

        };
      };

    nixos.desktops =
      { config, nyralib, ... }:

      let
        desktop = config.nyra.desktops.default;
      in
      {
        options.nyra.desktops.default = nyralib.mkDefaultOption "DE or WM" ./.;

        config = {
          services.displayManager.defaultSession = lib.mkDefault desktop;
        };
      };
  };
}
