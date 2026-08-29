{ lib, ... }:

{
  flake.modules.homeManager.files =
    { config, nyralib, ... }:

    let
      fileManager = config.nyra.files.default;
    in
    {
      options.nyra.files.default = nyralib.mkDefaultOption "file manager" ./.;

      config = {
        hyprnix.settings.bind = lib.mkIf (config.nyra.desktops.hyprland.enable) {
          "SUPER + E".dispatcher.exec_cmd = lib.mkDefault fileManager;
        };
      };
    };
}
