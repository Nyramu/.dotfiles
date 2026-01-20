{ lib, ... }:

{
  imports  = [
    ./zen
  ];

  options.nyra.home.apps = {
    defaultBrowser = lib.mkOption {
      type = lib.types.enum [ "zen-beta" ];
      default = "zen-beta";
      description = "Choose your default browser";
    };
  };  
}
