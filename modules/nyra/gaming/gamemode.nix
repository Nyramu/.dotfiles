{ self, lib, ... }:
{
  flake.modules.nixos = {
    gaming.imports = [ self.modules.nixos.gamemode ];

    gamemode =
      { config, user, ... }:

      let
        cfg = config.nyra.gaming.gamemode;
      in
      {
        options.nyra.gaming.gamemode = {
          enable = lib.mkEnableOption "gamemode";
        };

        config = lib.mkIf (cfg.enable) {
          programs.gamemode = {
            enable = true;
            enableRenice = true;
            settings = {
              general = {
                renice = 10;
              };
            };
          };
          # Needed to make the renice setting work
          users.users.${user.name}.extraGroups = [ "gamemode" ];
        };
      };
  };
}
