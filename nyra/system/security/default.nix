{ lib, ... }:

{
  imports = [
    ./fprint.nix
  ];

  # Pipewire needs it enabled
  security.rtkit.enable = lib.mkDefault true;
}
