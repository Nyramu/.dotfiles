{ ... }:
{
  flake.modules.homeManager.hyprland =
    { config, ... }:

    let
      cfg = config.nyra;

      makeFloating = class: {
        match.class = class;
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
    in
    {
      hyprnix.settings.window_rule = {
        "floating-viewer" = makeFloating "mpv|imv";
        "floating-${cfg.terminals.default}" = makeFloating "floating-${cfg.terminals.default}";
      };
    };
}
