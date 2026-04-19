{ config, ... }:

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
    }

    # Custom titles for terminal apps
    {
      name = "floating-${config.nyra.home.apps.defaultTerminal}";
      match.class = "floating-${config.nyra.home.apps.defaultTerminal}";
      float = true;
      center = true;
      min_size = [
        1280
        720
      ];
    }

    {
      name = "cassette-rmpc";
      match.initial_title = "rmpc";
      float = true;
      center = true;
      min_size = [
        942
        558
      ];
    }

    {
      name = "welcome-fastfetch";
      match.initial_title = "fastfetch";
      float = true;
      center = true;
      size = [
        1100
        736
      ];
    }
  ];
}
