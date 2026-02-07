{ config, pkgs, ... }:

{
  services.pulseaudio = {
    enable = config.nyra.audio.server == "pulseaudio";
    support32Bit = true;
    package = pkgs.pulseaudioFull;
    extraConfig = "load-module module-combine-sink";
  };

  services.pipewire = {
    enable = config.nyra.audio.server == "pipewire";
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;

    extraConfig.pipewire = {
      "10-clock-rate" = {
        "context.properties" = {
          # Fix audio popping/crackling while playing with Proton
          "default.clock.min-quantum" = 512; # Default: 32
        };
      };
      # Fix audio lag
      "92-bt-config" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 1024;
          "default.clock.min-quantum" = 512;
          "default.clock.max-quantum" = 2048;
        };
      };
    };
  };
}
