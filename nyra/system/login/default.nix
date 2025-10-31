{ config, lib, pkgs, ... }: with lib;

{
  imports = [
    ./sddm.nix
    ./user-icon.nix
  ];
}