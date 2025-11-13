{ config, lib, ... }: with lib;

let
  cfg = config.nyra.home.apps.media.rmpc;
in
{
  options.nyra.home.apps.media.rmpc = {
    enable = mkEnableOption "rmpc";
  };

  config = {
    services.mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/Music";
      playlistDirectory = "${config.home.homeDirectory}/Music/Playlists";
    };
    programs.rmpc.enable = cfg.enable;
  };
}

