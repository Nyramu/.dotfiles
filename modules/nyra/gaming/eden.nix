{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.modules.homeManager = {
    gaming.imports = [ self.modules.homeManager.eden ];

    eden =
      {
        config,
        pkgs,
        host,
        ...
      }:

      let
        cfg = config.nyra.gaming.eden;
        edenPkgs = inputs.eden.packages.${host.system};
      in
      {
        imports = [
          inputs.eden.homeModules.default
        ];

        options.nyra.gaming.eden = {
          enable = lib.mkEnableOption "eden";
        };

        config = lib.mkIf (cfg.enable) {
          programs.eden = {
            enable = true;
            package = if (host.name == "main") then edenPkgs.zen4 else edenPkgs.default;
          };

          home.packages = [ pkgs.nsz ];
        };
      };
  };
}
