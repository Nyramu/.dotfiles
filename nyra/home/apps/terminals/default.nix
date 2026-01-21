{ lib, ... }:

{
  imports = [
    ./alacritty.nix
    ./ghostty.nix
    ./kitty.nix
  ];

  options.nyra.home.apps = {
    defaultTerminal = lib.mkOption {
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
