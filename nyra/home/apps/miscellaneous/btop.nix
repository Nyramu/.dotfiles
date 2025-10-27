{ pkgs, lib, ... }:

{
  programs.btop = {
    enable = true;
    settings = {
      color_theme = lib.mkForce "TTY";
      theme_background = false;
      force_tty = true;
      update_ms = 100;
      # TODO: Make gpu appear in btop
      shown_boxes = "proc cpu mem net";
    };
  };
}
