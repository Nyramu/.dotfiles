{ lib, ... }:

let
  path = ./.;
in
{
  flake.modules.homeManager.files =
    { config, ... }:

    let
      fileManager = config.nyra.files.default;
    in
    {
      options.nyra.files.default = lib.mkOption {
        type = lib.types.enum (
          builtins.readDir path
          |> builtins.attrNames
          |> builtins.filter (n: n != "default.nix")
          |> map (n: lib.removeSuffix ".nix" n)
        );
      };

      config = {
        hyprnix.settings.bind = lib.mkIf (config.nyra.desktops.hyprland.enable) {
          "SUPER + E".dispatcher.exec_cmd = lib.mkDefault fileManager;
        };
      };
    };
}
