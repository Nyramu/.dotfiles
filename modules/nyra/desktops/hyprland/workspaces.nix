{ self, ... }:
{
  flake.modules.homeManager = {
    desktops.imports = [ self.modules.homeManager.hyprland ];

    hyprland = {
      hyprnix.settings = {
        workspaces = [
          {
            id = 1;
            rules.persistent = true;
          }
          {
            id = 2;
            rules.persistent = false;
          }
          {
            id = 3;
            rules.persistent = false;
          }
          {
            id = 4;
            rules.persistent = false;
          }
          {
            id = 5;
            rules.persistent = false;
          }
        ];
      };
    };
  };
}
