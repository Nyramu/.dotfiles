{ lib, ... }:

{
  options.nyra.audio = {
    server = lib.mkOption {
      type = lib.types.enum [
        "pipewire"
        "pulseaudio"
      ];
      default = "pulseaudio";
    };
  };
}
