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
              theme_background = false;
              update_ms = 1000;
              shown_boxes = "proc cpu gpu0 mem net";
              custom_gpu_name0 = cfg.gpu-name;
            };
          };

          hyprnix.settings.bind = lib.mkIf (config.nyra.desktops.hyprland.enable) {
            "SUPER + H".dispatcher.exec_cmd = "${config.nyra.terminals.default} -e btop";
          };
        };
      };
  };
}
