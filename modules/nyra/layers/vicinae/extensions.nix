{ inputs, ... }:
{
  flake.modules.homeManager.vicinae =
    { host, ... }:
    {
      programs.vicinae = {
        extensions =
          with inputs.vicinae-extensions.packages.${host.system};
          with inputs.vicinae.packages.${host.system};
          [
            color-converter
            protondb-search
          ];
      };
    };
}
