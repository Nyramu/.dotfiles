{ config, lib, ... }:

{
  imports = [
    ./editors
    ./terminals
    ./browsers
    ./files
    ./misc
    ./socials
  ];

  options.nyra.apps = {
    packages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
    };
  };

  config = {
    home.packages = config.nyra.apps.packages;
  };
}
