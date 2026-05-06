{ lib, ... }:

{
  imports = [
    ./alacritty.nix
    ./ghostty.nix
    ./kitty.nix
  ];

  options.nyra.apps.terminals = {
    default = lib.mkOption {
      type = lib.types.enum [
        "alacritty"
        "ghostty"
        "kitty"
      ];
      default = "kitty";
      description = "Choose your terminal emulator";
    };
  };
}
