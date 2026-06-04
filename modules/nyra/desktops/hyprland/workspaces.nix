{ ... }:
{
  flake.modules.homeManager.hyprland = {
    hyprnix.settings = {
      workspace_rule = {
        "1" = {
          default = true;
          persistent = true;
        };
        "2" = {
          persistent = false;
        };
        "3" = {
          persistent = false;
        };
        "4" = {
          persistent = false;
        };
        "5" = {
          persistent = false;
        };
      };
    };
  };
}
