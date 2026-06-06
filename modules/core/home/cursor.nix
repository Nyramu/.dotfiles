{ self, lib, ... }:
{
  flake.modules.homeManager = {
    core.imports = [ self.modules.homeManager.cursor ];

    cursor =
      { pkgs, ... }:
      {
        home.pointerCursor = {
          enable = true;
          package = lib.mkDefault pkgs.rose-pine-hyprcursor;
          name = lib.mkDefault "rose-pine-hyprcursor";
          size = lib.mkDefault 36;
          hyprcursor.enable = lib.mkDefault true;
        };
      };
  };
}
