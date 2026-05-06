{
  config,
  lib,
  pkgs,
  ...
}:

let
  audio = config.nyra.hardware.audio;
  cfg = config.nyra.services.mpd;
in
{
  options.nyra.services.mpd = {
    enable = lib.mkEnableOption "mpd";
  };

  config = lib.mkIf (cfg.enable) {
    services.mpd = {
      enable = true;
      musicDirectory = "${config.home.homeDirectory}/Music";
      playlistDirectory = "${config.home.homeDirectory}/Music/Playlists";
      extraConfig =
        if (audio.server == "pipewire") then
          ''
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
        else
          ''
            audio_output {
              type       "pulse"
              name       "PulseAudio"
              mixer_type "software"
            }
          '';
    };
    services.mpd-mpris.enable = true;
    programs.cava = {
      enable = true;
    };
    home.packages = [ pkgs.mpc ];
  };
}
