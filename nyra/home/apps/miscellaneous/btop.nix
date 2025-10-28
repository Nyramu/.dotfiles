{ config, lib, pkgs, ... }: with lib;

let 
  cfg = config.nyra.home.apps.miscellaneous;
in 
{
  options.nyra.home.apps.miscellaneous = {
    btop.enable = mkEnableOption "btop";
  };

  config = {
    programs.btop = {
      enable = cfg.btop.enable;
      settings = {
        color_theme = lib.mkForce "TTY";
        theme_background = false;
        force_tty = true;
        update_ms = 1000;
        # TODO: Make gpu appear in btop
        shown_boxes = "proc cpu mem net";
      };
    };
  };
}
