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
      support32Bit = true;
      package = pkgs.pulseaudioFull;
      extraConfig = "load-module module-combine-sink";
    };
    
    services.pipewire = {
      enable = cfg.server == "pipewire";
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
  };
}
