{ config, lib, pkgs, ... }: with lib;

{
  imports = [
    ./sddm
    ./user-icon.nix
  ];
}
