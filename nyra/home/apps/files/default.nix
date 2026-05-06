{ lib, ... }:

{
  imports = [
    ./yazi
  ];

  options.nyra.apps.files = {
    default = lib.mkOption {
      type = lib.types.enum [ "yazi" ];
      default = "yazi";
      description = "Choose your default file manager";
    };
  };
}
