{ lib,  ... }: with lib;

{
  imports = [
    ./alacritty.nix
    ./ghostty.nix
    ./kitty.nix
  ];

  options.nyra.home.apps.terminals = {
    default = mkOption {
      type = types.enum [ "alacritty" "ghostty" "kitty" ];
      default = "kitty";
      description = "Choose your terminal emulator";
    };
  };
}
