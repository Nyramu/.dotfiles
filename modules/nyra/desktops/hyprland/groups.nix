{ self, ... }:
{
  flake.modules.homeManager = {
    desktops.imports = [ self.modules.homeManager.hyprland ];

    hyprland = {
      hyprnix.settings.group = {
        auto_group = true;
        insert_after_current = true;
        focus_removed_window = true;
        drag_into_group = 2; # Only on group bar
        merge_groups_on_drag = false;
        # group_on_movetoworkspace = true; # Must test

        groupbar = {
          font_size = 13;
          gradients = false;
          indicator_height = 1; # Default: 3
          rounding = 8;
          rounding_power = 4.0; # Default: 2.0
          blur = true;
        };
      };
    };
  };
}
