{ lib, ... }: with lib;

{
  imports  = [
    ./firefox.nix
    ./librewolf.nix
    ./qutebrowser.nix
    ./zen.nix
  ];

  options.nyra.home.apps.browsers = {
    default = mkOption {
      type = types.enum [ "firefox" "librewolf" "qutebrowser" "zen" ];
      default = "qutebrowser";
      description = "Choose your default browser";
    };
  };  
}
