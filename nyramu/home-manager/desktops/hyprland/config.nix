{ pkgs, inputs, config, lib, ... }:

let
  # Fetch wallpapers 
  wallpaper = pkgs.fetchurl {
    url = "https://wallscloud.net/img/resize/1920/1200/MM/2016-12-09-japanese-architecture-pixel-art-o69K.png";
    sha256 = "sha256-Z865YmTyXQd7ictAE/63JhxbUEyoM48GaJDL3XIoWT8=";
  };

  wallpaper2 = pkgs.fetchurl {
    url = "https://i.imgur.com/CJVlDCD.jpeg";
    sha256 = "sha256-E9HWbmiUBGXiTDU9otXTu5LPBKcHMsEMtzEwdhaIX3M=";
  };

  wallpaper3 = pkgs.fetchurl {
    url = "https://r4.wallpaperflare.com/wallpaper/342/168/1015/waneella-pixel-art-city-sunset-hd-wallpaper-b40612242749e2adddac705dda8a0e2a.jpg";
    sha256 = "sha256-xAz9egVTCnrM2gqU6T3lMVwA3lt2B4abOySq0Pd9/FM=";
  };

  wallpaper4 = pkgs.fetchurl {
    url = "https://r4.wallpaperflare.com/wallpaper/666/221/94/waneella-pixel-art-city-street-neon-hd-wallpaper-b4a662c4e75982adadfce01dbaba1eba.jpg";
    sha256 = "sha256-9Rq78xl2w09+Vn6GW2xV6hAS9ZsP8yeMIjN8niIiLlA=";
  };

in 
{   
  wayland.windowManager.hyprland = {
    # <https://wiki.hyprland.org/Configuring/Variables/#general>
    config.general = {
      border_size = 3;
      gaps_inside = 5;
      gaps_outside = 25;
      active_border_color = "rgb(542624) rgb(d66e65) 270deg";
      inactive_border_color = "rgb(152927)";
      resize_on_border = true;
    };

    config.decoration = {
      rounding = 0;
      shadow = {
        range = 5;
        render_power = 3;
        color = "rgba(1a1a1aee)";
      };
    };

    #animations.animation = {
    #  
    #};

    # Set wallpaper
    config.exec = [ "swaybg -m fill -i ${config.stylix.image}" ];
  };
    
  home.packages = with pkgs; [ swaybg ];
}   
