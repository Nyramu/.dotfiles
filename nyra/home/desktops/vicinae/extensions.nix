{
  inputs,
  pkgs,
  ...
}:

{
  services.vicinae = {
    extensions =
      with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system};
      with inputs.vicinae.packages.${pkgs.stdenv.hostPlatform.system};
      [
        hypr-keybinds
        color-converter
        process-manager
        nerdfont-search
        # (mkRayCastExtension {
        #   name = "spotify-player";
        #   rev = "6a460e74c44e389ff5a12534a0f64ed82c92bd31";
        #   hash = "sha256-iyJctGxLx5Tso2JRJxHpYUJlRnKVLBty7gV8kO5WSbk=";
        # })
      ];
  };
}
