{ inputs, ... }:
{
  flake.modules.homeManager.vicinae =
    { pkgs, ... }:
    {
      programs.vicinae = {
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
