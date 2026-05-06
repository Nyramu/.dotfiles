{ lib, ... }:

{
  options.nyra.hardware.audio = {
    server = lib.mkOption {
      type = lib.types.enum [
        "pipewire"
        "pulseaudio"
      ];
      default = "pulseaudio";
    };
  };
}
