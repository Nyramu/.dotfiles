{ ... }:

{
  wayland.windowManager.hyprland = {
    config = {
      windowrule = [
        "match:class ^(mpv)$, float on"
        "match:class ^(mpv)$, size 1280 720"
        "match:class ^(mpv)$, center on"

        "match:class ^(imv)$, float on"
        "match:class ^(imv)$, size 1280 720"
        "match:class ^(imv)$, center on"

        # Custom titles for kitty
        "match:initial_title ^(rmpc)$, float on"
        "match:initial_title ^(rmpc)$, size 942 558"
        "match:initial_title ^(rmpc)$, center on"

        "match:initial_title ^(fastfetch)$, float on"
        "match:initial_title ^(fastfetch)$, size 1100 736"
        "match:initial_title ^(fastfetch)$, center on"
      ];
    };
  };
}
