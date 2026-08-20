{ lib, ... }:

let
  path = ./.;

  defaultOpt = lib.mkOption {
    type = lib.types.nullOr (
      lib.types.enum (
        builtins.readDir path
        |> builtins.attrNames
        |> builtins.filter (n: n != "default.nix")
        |> map (n: lib.removeSuffix ".nix" n)
      )
    );
  };
in
{
  flake.modules = {
    homeManager.desktops =
      { config, ... }:

      let
        desktop = config.nyra.desktops.default;
      in
      {
        options.nyra.desktops.default = defaultOpt;

        config = {

        };
      };

    nixos.desktops =
      { config, ... }:

      let
        desktop = config.nyra.desktops.default;
      in
      {
        options.nyra.desktops.default = defaultOpt;

        config = {
          services.displayManager.defaultSession = lib.mkDefault desktop;
        };
      };
  };
}
