{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nautilus
    nautilus-open-any-terminal
  ];

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "alacritty";
  };
}
