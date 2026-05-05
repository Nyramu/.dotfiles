{
  config,
  lib,
  ...
}:

let
  cfg = config.nyra.wayland;
in
{
  options.nyra.wayland = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable wayland support";
    };
    xwayland = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "enable xwayland support";
      };
    };
  };

  config = lib.mkIf (cfg.enable == true) {
    nyra.wayland.xwayland.enable = lib.mkDefault true;
  };
}
