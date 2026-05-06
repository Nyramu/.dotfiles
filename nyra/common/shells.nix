{ lib, ... }:

{
  options.nyra.shells = {
    default = lib.mkOption {
      type = lib.types.enum [
        "zsh"
        "nushell"
      ];
      default = "zsh";
      description = "Choose default shell";
    };
  };
}
