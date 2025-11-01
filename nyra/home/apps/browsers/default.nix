{ lib, ... }: with lib;

{
  imports  = [
    ./firefox.nix
    ./librewolf.nix
  ];

  options.nyra.home.apps.browsers = {
    default = mkOption {
      type = types.enum [ "firefox" "librewolf" ];
      default = "librewolf";
      description = "Choose your default browser";
    };
  };  
}
