{ lib, ... }:

{
  imports = [
    ./zen
  ];

  options.nyra.home.apps = {
    defaultBrowser = lib.mkOption {
      type = lib.types.enum [ "zen-twilight" ];
      default = "zen-twilight";
      description = "Choose your default browser";
    };
  };
}
