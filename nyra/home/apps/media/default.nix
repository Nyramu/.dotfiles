{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.home.apps.media;
in
{
  imports = [
    ./music
  ];

  options.nyra.home.apps.media = {
    vlc.enable = mkEnableOption "vlc";
  };

  config = {
    home.packages = with pkgs;
      optionals (cfg.vlc.enable) [ vlc ];
  };
}
