{ lib, ... }:

{
  flake.modules.homeManager.editors =
    { config, nyralib, ... }:

    let
      editor = config.nyra.editors.default;
    in
    {
      options.nyra.editors.default = nyralib.mkDefaultOption "editor" ./.;

      config = {
        hyprnix.settings.bind = lib.mkIf (config.nyra.desktops.hyprland.enable) {
          "SUPER + BACKSPACE".dispatcher.exec_cmd = lib.mkDefault editor;
        };
      };
    };
}
