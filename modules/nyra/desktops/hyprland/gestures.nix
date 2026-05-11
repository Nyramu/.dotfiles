{ ... }:
{
  flake.modules.homeManager.hyprland = {
    hyprnix.settings = {
      gesture = {
        # workspace_swipe_create_new = false;
        gestures = [
          {
            fingers = 3;
            direction = "pinch";
            action = {
              dispatcher = "fullscreen, maximize";
            };
          }
          {
            fingers = 3;
            direction = "vertical";
            action = "workspace";
          }
        ];
      };
    };
  };
}
