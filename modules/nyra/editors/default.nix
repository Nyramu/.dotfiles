{ lib, ... }:

let
  path = ./.;
in
{
  flake.modules.homeManager.editors =
    { config, ... }:

    let
      editor = config.nyra.editors.default;
    in
    {
      options.nyra.editors.default = lib.mkOption {
        type = lib.types.enum (
          builtins.readDir path
          |> builtins.attrNames
          |> builtins.filter (n: n != "default.nix")
          |> map (n: lib.removeSuffix ".nix" n)
        );
      };

      config = {
        hyprnix.settings.bind = lib.mkIf (config.nyra.desktops.hyprland.enable) {
          "SUPER + BACKSPACE".dispatcher.exec_cmd = lib.mkDefault editor;
        };
      };
    };
}
