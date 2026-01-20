{ config, lib, ... }:

{
  imports = [
    ./productivity
    ./terminals
    ./browsers
    ./gaming
    ./miscellaneous
    ./socials
  ];

  options.nyra.home.apps = {
    packages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
    };
  };

  config = {
    home.packages = config.nyra.home.apps.packages;
  };
}
