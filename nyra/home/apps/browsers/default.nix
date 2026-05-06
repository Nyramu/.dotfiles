{ lib, ... }:

{
  imports = [
    ./zen
  ];

  options.nyra.apps.browsers = {
    default = lib.mkOption {
      type = lib.types.enum [ "zen-twilight" ];
      default = "zen-twilight";
      description = "Choose your default browser";
    };
  };
}
