{ self, lib, ... }:
{
  flake.modules.homeManager.hyprland =
    { config, ... }:

    let
      cfg = config.nyra;
    in
    {
      imports = with self.modules.homeManager; [
        terminals
        fastfetch
        rmpc
      ];

      hyprnix.settings.window_rule = {
        "floating-mpv" = {
          match.class = "mpv";
          float = true;
          center = true;
          min_size = [
            1280
            720
          ];
          size = [
            1280
            720
          ];
          dim_around = true;
        };
        "floating-imv" = {
          match.class = "imv";
          float = true;
          center = true;
          min_size = [
            1280
            720
          ];
          size = [
            1280
            720
          ];
        };
        "floating-${cfg.terminals.default}" = {
          match.class = "floating-${cfg.terminals.default}";
          float = true;
          center = true;
          min_size = [
            1280
            720
          ];
          size = [
            1280
            720
          ];
        };
      }
      // lib.optionalAttrs cfg.music.rmpc.enable {
        "cassette-rmpc" = {
          match.initial_title = "rmpc";
          float = true;
          center = true;
          min_size = [
            942
            558
          ];
          size = [
            942
            558
          ];
        };
      }
      // lib.optionalAttrs cfg.miscellaneous.fastfetch.enable {
        "welcome-fastfetch" = {
          match.initial_title = "fastfetch";
          float = true;
          center = true;
          min_size = [
            1100
            736
          ];
          size = [
            1100
            736
          ];
        };
      };
    };
}
