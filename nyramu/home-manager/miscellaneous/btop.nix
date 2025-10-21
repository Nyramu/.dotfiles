{ pkgs, ... }:

{
  programs.btop = {
    enable = true;
    theme_background = true;
    force_tty = true;
    update_ms = 100;
  };
}
