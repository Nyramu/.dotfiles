{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.modules.nixos = {
    gaming.imports = [ self.modules.nixos.eden ];

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
          inputs.eden.nixosModules.default
        ];

        options.nyra.gaming.eden = {
          enable = lib.mkEnableOption "Eden Emulator";
        };

        config = lib.mkIf (cfg.enable) {
          programs.eden = {
            enable = true;
            package = if (host.name == "main") then edenPkgs.zen4 else edenPkgs.default;
          };

          environment.systemPackages = [ pkgs.nsz ];
        };
      };
  };
}
