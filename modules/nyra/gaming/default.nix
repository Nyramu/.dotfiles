{ lib, ... }:
{
  flake.modules.homeManager.gaming =
    { config, ... }:

    let
      dirs = config.xdg.userDirs;
    in
    {
      home.sessionVariables = lib.mkIf (lib.any (x: x.enable) (lib.attrValues config.nyra.gaming)) {
        XDG_GAMES_DIR = dirs.extraConfig.GAMES;
      };

      xdg.userDirs.extraConfig = lib.mkIf (lib.any (x: x.enable) (lib.attrValues config.nyra.gaming)) {
        GAMES = "${config.home.homeDirectory}/Games";
      };
    };
}
