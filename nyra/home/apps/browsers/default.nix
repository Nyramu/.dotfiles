{ lib, ... }: with lib;

{
  imports  = [
    ./firefox.nix
    ./librewolf.nix
    ./qutebrowser.nix
  ];

  options.nyra.home.apps.browsers = {
    default = mkOption {
      type = types.enum [ "firefox" "librewolf" "qutebrowser" ];
      default = "qutebrowser";
      description = "Choose your default browser";
    };
  };  
}
