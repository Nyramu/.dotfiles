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
        noctalia-shell-wallpaper-selector
        protondb-search
      ];
  };
}
