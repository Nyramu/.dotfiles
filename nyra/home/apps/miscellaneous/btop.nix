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
      package = pkgs.btop-rocm;
      settings = {
        color_theme = lib.mkForce "TTY";
        theme_background = false;
        force_tty = true;
        update_ms = 100;
        shown_boxes = "proc cpu gpu0 mem net";
        custom_gpu_name0 = "Radeon 780M";
      };
    };
  };
}
