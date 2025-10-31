{ lib, ... }:

{
  imports = [
    ./fingerprint.nix
  ];

  # Pipewire needs it enabled
  security.rtkit.enable = lib.mkDefault true;
}
