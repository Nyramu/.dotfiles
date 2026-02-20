{ lib, ... }:

{
  imports = [
    ./rmpc.nix
    ./btop.nix
    ./fastfetch.nix
    ./zellij.nix
    ./packet-tracer.nix
    ./spotiflac.nix
    ./spicetify.nix
    ./yazi
  ];

  options.nyra.home.apps = {
    defaultFileManager = lib.mkOption {
      type = lib.types.enum [ "yazi" ];
      default = "yazi";
      description = "Choose your default file manager";
    };
  };
}
