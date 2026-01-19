{ config, lib, ... }:

{
  options.nyra.home.services.mpd = {
    enable = lib.mkEnableOption "mpd";
  };

  config = {
    services.mpd = {
      enable = config.nyra.home.services.mpd.enable;
      musicDirectory = "${config.home.homeDirectory}/Music";
      playlistDirectory = "${config.home.homeDirectory}/Music/Playlists";
      extraConfig = if (config.nyra.audio.server == "pipewire") then ''
        audio_output {
          type       "pipewire"
          name       "PipeWire"
          mixer_type "software"
        }

        audio_output {
          type    "fifo"
          name    "Visualizer"
          path    "/tmp/mpd.fifo"
          format  "44100:16:2"
        }

        auto_update "yes"
      ''
      else ''
        audio_output {
          type       "pulse"
          name       "PulseAudio"
          mixer_type "software"
        }
      '';
    };
    services.mpd-mpris.enable = config.services.mpd.enable;
    programs.cava = {
      enable = config.nyra.home.services.mpd.enable;
    };
  };
}
