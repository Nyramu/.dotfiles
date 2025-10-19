{ pkgs, inputs, ... }:

{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix.enable = true;

  stylix.polarity = "dark";

  stylix.image = pkgs.fetchurl {
    url = "https://r4.wallpaperflare.com/wallpaper/342/168/1015/waneella-pixel-art-city-sunset-hd-wallpaper-b40612242749e2adddac705dda8a0e2a.jpg";
    hash = "sha256-xAz9egVTCnrM2gqU6T3lMVwA3lt2B4abOySq0Pd9/FM=";
  };

  stylix.autoEnable = true;

  stylix.base16Scheme = ../styles/sunset.yaml;

}
