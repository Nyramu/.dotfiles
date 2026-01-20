{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.home.apps.editors;
in
{
  imports = [
    ./nvf.nix
    ./helix.nix
  ];

  options.nyra.home.apps.editors = {
    gimp.enable = mkEnableOption "gimp";
    aseprite.enable = mkEnableOption "aseprite";
    intellij.enable = mkEnableOption "intellij";
  };

  config = {
    home.packages = with pkgs;
      optionals (cfg.gimp.enable) [ gimp-with-plugins ] ++
      optionals (cfg.aseprite.enable) [ aseprite ] ++
      optionals (cfg.intellij.enable) [
       jetbrains.idea openjdk25
     ];
  };
}
