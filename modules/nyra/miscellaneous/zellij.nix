{ self, lib, ... }:
{
  flake.modules.homeManager = {
    miscellaneous.imports = [ self.modules.homeManager.zellij ];

    zellij =
      { config, ... }:

      let
        cfg = config.nyra.miscellaneous.zellij;
      in
      {
        options.nyra.miscellaneous.zellij = {
          enable = lib.mkEnableOption "zellij";
        };

        config = lib.mkIf (cfg.enable) {
          programs.zellij = {
            enable = true;
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
      };
  };
}
