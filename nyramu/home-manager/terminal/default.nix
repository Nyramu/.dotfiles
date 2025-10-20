{ ... }:

{
  imports = [
    ./kitty.nix
    ./zsh.nix
  ];

  programs.alacritty.enable = true;
}
