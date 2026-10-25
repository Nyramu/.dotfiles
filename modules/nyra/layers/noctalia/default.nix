{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.modules.homeManager = {
    layers.imports = [ self.modules.homeManager.noctalia ];

    noctalia =
      {
        config,
        nyralib,
        ...
      }:

      let
        cfg = config.nyra.layers.noctalia;
      in
      {
        imports = [
          inputs.noctalia.homeModules.default
        ];

        options.nyra.layers.noctalia = {
          enable = nyralib.mkEnabledOption "Noctalia";
        };

        config = lib.mkIf (cfg.enable) {
          programs.noctalia = {
            enable = true;
            systemd.enable = true;
            settings = {
            };
          };
        };
      };
  };
}
