{ self, lib, ... }:
{
  flake.modules.homeManager = {
    miscellaneous.imports = [ self.modules.homeManager.btop ];

    btop =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.miscellaneous.btop;
      in
      {
        options.nyra.miscellaneous.btop = {
          enable = lib.mkEnableOption "btop";
          gpu-name = lib.mkOption {
            type = lib.types.str;
            default = "";
            description = "GPU name to display in btop++";
          };
        };

        config = lib.mkIf (cfg.enable) {
          programs.btop = {
            enable = true;
            package = pkgs.btop-rocm;
            settings = {
              color_theme = lib.mkForce "TTY";
              theme_background = false;
              force_tty = true;
              update_ms = 1000;
              shown_boxes = "proc cpu gpu0 mem net";
              custom_gpu_name0 = cfg.gpu-name;
            };
          };
        };
      };
  };
}
