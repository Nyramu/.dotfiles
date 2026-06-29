{ lib, ... }:

let
  path = ./.;
in
{
  flake.modules.homeManager.browsers =
    { config, ... }:

    let
      browser = config.nyra.browsers.default;
    in
    {
      options.nyra.browsers.default = lib.mkOption {
        type = lib.types.enum (
          builtins.readDir path
          |> builtins.attrNames
          |> builtins.filter (n: n != "default.nix")
          |> map (n: lib.removeSuffix ".nix" n)
        );
      };

      config = {
        hyprnix.settings.bind = lib.mkIf (config.nyra.desktops.hyprland.enable) {
          "SUPER + B".dispatcher.exec_cmd = browser;
        };
      };
    };
}
