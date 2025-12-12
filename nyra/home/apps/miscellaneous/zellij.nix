{ config, lib, ... }: with lib;

let
  shellCfg = config.nyra.home.shells;
  cfg = config.nyra.home.apps.miscellaneous.zellij;
in
{
  options.nyra.home.apps.miscellaneous.zellij = {
    enable = mkOption {
      type = types.bool;
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
        ui = { pane_frames = { hide_session_name = true; }; };
      };
    };
  };
}
