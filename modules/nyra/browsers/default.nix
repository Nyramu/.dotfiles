{ lib, ... }:

let
  path = ./.;
in
{
  flake.modules.homeManager.browsers = {
    options.nyra.browsers.default = lib.mkOption {
      type = lib.types.enum (
        builtins.readDir path
        |> builtins.attrNames
        |> builtins.filter (n: n != "default.nix")
        |> map (n: lib.removeSuffix ".nix" n)
      );
    };
  };
}
