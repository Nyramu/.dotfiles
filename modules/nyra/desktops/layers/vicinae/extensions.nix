{ inputs, ... }:
{
  flake.modules.homeManager.vicinae =
    { pkgs, ... }:
    {
      services.vicinae = {
        extensions =
          with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system};
          with inputs.vicinae.packages.${pkgs.stdenv.hostPlatform.system};
          [
            color-converter
            nerdfont-search
            protondb-search
          ];
      };
    };
}
