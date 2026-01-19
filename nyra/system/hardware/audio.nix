{ config, lib, pkgs, ... }:

let
  cfg = config.nyra.audio;
in
{
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

    extraConfig.pipewire = {
      "10-clock-rate" = {
        "context.properties" = {
          # Fix for audio popping and crackling while playing through Proton
          "default.clock.min-quantum" = 512; # Default: 32
        };
      };
    };
  };

  security.rtkit.enable = lib.mkDefault cfg.server == "pipewire";
}
