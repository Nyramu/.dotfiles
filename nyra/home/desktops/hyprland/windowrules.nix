{ ... }:

{
  hyprnix.settings.windowrules = [
    {
      name = "floating-mpv";
      match.class = "mpv";
      float = true;
      center = true;
      size = [
        1280
        720
      ];
    }

    {
      name = "floating-imv";
      match.class = "imv";
      float = true;
      center = true;
      size = [
        1280
        720
      ];
    }

    # Custom titles for kitty
    {
      name = "cassette-rmpc";
      match.initial_title = "rmpc";
      float = true;
      center = true;
      size = [
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
