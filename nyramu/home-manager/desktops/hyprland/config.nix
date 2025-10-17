{ pkgs, inputs, ... }:

let
  # Fetch wallpapers 
  wallpaper = pkgs.fetchurl {
    url = "https://wallscloud.net/img/resize/1920/1200/MM/2016-12-09-japanese-architecture-pixel-art-o69K.png";
    sha256 = pkgs.lib.fakeSha256;
  };
in
{
  wayland.windowManager.hyprland = {
    # <https://wiki.hyprland.org/Configuring/Variables/#general>
    config.general = {
      border_size = 2;
      gaps_inside = 5;
      gaps_outside = 20;
      active_border_color = rgba(ff6a00d4) rgba(ff42a5ed) 45deg;
      inactive_border_color = rgba(595959aa);
      resize_on_border = true;
    };

    config.decoration = {
      rounding = 0;
      shadow = {
        range = 5;
        render_power = 3;
        color = rgba(1a1a1aee);
      };
    };

    #animations.animation = {
    #  
    #};
  };

}
