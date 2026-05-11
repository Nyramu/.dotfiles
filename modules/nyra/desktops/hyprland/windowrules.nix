{ lib, ... }:
{
  flake.modules.homeManager.hyprland =
    { config, ... }:

    let
      inherit (config.nyra) terminals miscellaneous music;
    in
    {
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
          name = "floating-${terminals.default}";
          match.class = "floating-${terminals.default}";
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
      ++ lib.optional (music.rmpc.enable) {
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
      ++ lib.optional (miscellaneous.fastfetch.enable) {
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
