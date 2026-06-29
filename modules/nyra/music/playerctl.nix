{ self, lib, ... }:
{
  flake.modules.homeManager = {
    music.imports = [ self.modules.homeManager.playerctl ];

    playerctl =
      { config, ... }:

      let
        music = config.nyra.music;
        cfg = music.playerctl;
      in
      {
        options.nyra.music.playerctl = {
          enable = lib.mkEnableOption "playerctl";
        };

        config = {
          services.playerctld = lib.mkIf (cfg.enable) {
            enable = true;
          };

          nyra.music.playerctl.enable = lib.mkDefault (music.spicetify.enable || music.mpd.enable);

          hyprnix.settings.bind = lib.mkIf (config.nyra.desktops.hyprland.enable) {
            XF86AudioPlay = {
              dispatcher.exec_cmd = "playerctl play-pause";
              flags.locked = true;
            };
            XF86AudioPrev = {
              dispatcher.exec_cmd = "playerctl previous";
              flags.locked = true;
            };
            "SUPER + CTRL + left" = {
              dispatcher.exec_cmd = "playerctl previous";
              flags.locked = true;
            };
            XF86AudioNext = {
              dispatcher.exec_cmd = "playerctl next";
              flags.locked = true;
            };
            "SUPER + CTRL + right" = {
              dispatcher.exec_cmd = "playerctl next";
              flags.locked = true;
            };
          };
        };
      };
  };
}
