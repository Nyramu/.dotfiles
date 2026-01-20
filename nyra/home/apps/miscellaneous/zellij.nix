{ config, lib, ... }:

let
  cfg = config.nyra.home.apps.zellij;
in
{
  options.nyra.home.apps.zellij = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "zellij";
    };
  };

  config = {
    programs.zellij = {
      enable = cfg.enable;
      settings = {
        on_force_close = "quit";
        pane_frames = false;
        default_layout = "compact";
        default_mode = "locked";
        show_release_notes = false;
        show_startup_tips = false;
        ui = {
          pane_frames = {
            rounded_corners = true;
            hide_session_name = true;
          };
        };
      };
    };
  };
}
