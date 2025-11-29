{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (callPackage ./nyra.nix {})
  ];
}
