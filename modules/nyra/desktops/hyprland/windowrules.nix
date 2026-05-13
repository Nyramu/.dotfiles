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

      hyprnix.settings.windowrules = [
        {
          name = "floating-mpv";
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
        }

        {
          name = "floating-imv";
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
        }

        # Custom titles for terminal apps
        {
          name = "floating-${cfg.terminals.default}";
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
        }
      ]
      ++ lib.optional (cfg.music.rmpc.enable) {
        name = "cassette-rmpc";
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
      }
      ++ lib.optional (cfg.miscellaneous.fastfetch.enable) {
        name = "welcome-fastfetch";
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
}
