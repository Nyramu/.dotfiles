{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.system.audio;
in
{
  options.nyra.system.audio = {
    server = mkOption {
      type = types.enum [ "pipewire" "pulseaudio" ];
      default = "pulseaudio";
    };
  };

  config = {
    services.pulseaudio = {
      enable = cfg.server == "pulseaudio";
      support32Bit = cfg.server == "pulseaudio";
      package = mkIf (cfg.server == "pulseaudio") pkgs.pulseaudioFull;
    };
    
    services.pipewire = {
      enable = cfg.server == "pipewire";
      alsa.enable = cfg.server == "pipewire";
      alsa.support32Bit = cfg.server == "pipewire";
      pulse.enable = cfg.server == "pipewire";
    };
    
    security.rtkit.enable = cfg.server == "pipewire";
  };
}
