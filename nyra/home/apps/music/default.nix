{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.home.apps.music;
in
{
  options.nyra.home.apps.music = {
    mpv.enable = mkEnableOption "mpv";
  };

  config = {
    programs.mpv.enable = cfg.mpv.enable;
  };
}
