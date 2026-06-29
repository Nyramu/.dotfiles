{ lib, ... }:

let
  path = ./.;
in
{
  flake.modules.homeManager.terminals =
    { config, ... }:

    let
      terminal = config.nyra.terminals.default;
    in
    {
      options.nyra.terminals.default = lib.mkOption {
        type = lib.types.enum (
          builtins.readDir path
          |> builtins.attrNames
          |> builtins.filter (n: n != "default.nix")
          |> map (n: lib.removeSuffix ".nix" n)
        );
      };

      config = {
        hyprnix.settings.bind = lib.mkIf (config.nyra.desktops.hyprland.enable) {
          "SUPER + RETURN".dispatcher.exec_cmd = terminal;
          "SUPER + ALT + RETURN".dispatcher.exec_cmd = "${terminal} --class floating-${terminal}";
        };
      };
    };
}
