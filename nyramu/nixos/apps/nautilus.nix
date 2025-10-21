{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nautilus
    nautilus-open-any-terminal
  ];

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "alacritty";
  };
}
