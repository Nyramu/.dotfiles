{ lib, ... }:

{
  flake.modules.homeManager.terminals =
    { config, nyralib, ... }:

    let
      terminal = config.nyra.terminals.default;
    in
    {
      options.nyra.terminals.default = nyralib.mkDefaultOption "terminal emulator" ./.;

      config = {
        hyprnix.settings.bind = lib.mkIf (config.nyra.desktops.hyprland.enable) {
          "SUPER + RETURN".dispatcher.exec_cmd = terminal;
          "SUPER + ALT + RETURN".dispatcher.exec_cmd = "${terminal} --class floating-${terminal}";
        };
      };
    };
}
