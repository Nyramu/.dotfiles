{ config, pkgs, ... }:

let
  theme = import config.nyra.theme.path { inherit pkgs; };
in
{
  hyprnix.settings.group = {
    auto_group = true;
    insert_after_current = true;
    focus_removed_window = true;
    drag_into_group = 2; # Only on group bar
    merge_groups_on_drag = false;
    # group_on_movetoworkspace = true; # Must test

    col = {
      border_active = theme.hypr.active_border_color;
      border_inactive = theme.hypr.inactive_border_color;
      border_locked_active = theme.hypr.locked_group_active_border_color;
      border_locked_inactive = theme.hypr.inactive_border_color;
    };

    groupbar = {
      font_size = 13;
      gradients = false;
      indicator_height = 1; # Default: 3
      rounding = 8;
      rounding_power = 4.0; # Default: 2.0
      blur = true;

      text_color = theme.hypr.text_color;
      text_color_inactive = theme.hypr.inactive_text_color;
      text_color_locked_active = theme.hypr.locked_group_active_text_color;
      text_color_locked_inactive = theme.hypr.inactive_text_color;

      col = {
        active = theme.hypr.active_color;
        inactive = theme.hypr.inactive_color;
        locked_active = theme.hypr.locked_group_active_color;
        locked_inactive = theme.hypr.inactive_color;
      };
    };
  };
}
