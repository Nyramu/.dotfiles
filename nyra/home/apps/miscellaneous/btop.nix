{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.nyra.home.apps.btop;
in
{
  options.nyra.home.apps.btop = {
    enable = lib.mkEnableOption "btop";
    gpu-name = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "GPU name to display in btop++";
    };
  };

  config = {
    programs.btop = {
      enable = cfg.enable;
      package = pkgs.btop-rocm;
      settings = {
        color_theme = lib.mkForce "TTY";
        theme_background = false;
        force_tty = true;
        update_ms = 100;
        shown_boxes = "proc cpu gpu0 mem net";
        custom_gpu_name0 = cfg.gpu-name;
      };
    };
  };
}
