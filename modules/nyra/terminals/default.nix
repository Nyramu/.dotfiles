{ lib, ... }:

let
  path = ./.;
in
{
  flake.modules.homeManager.terminals.default = {
    options.nyra.terminals.default = lib.mkOption {
      type = lib.types.enum (
        builtins.readDir path
        |> builtins.attrNames
        |> builtins.filter (n: n != "default.nix")
        |> map (n: lib.removeSuffix ".nix" n)
      );
    };
  };
}
