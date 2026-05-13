{ self, lib, ... }:
{
  flake.modules.nixos = {
    miscellaneous.imports = [ self.modules.nixos.bashmount ];

    bashmount =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.miscellaneous.bashmount;
      in
      {
        options.nyra.miscellaneous.bashmount = {
          enable = lib.mkEnableOption "bashmount (with udisk2)";
        };

        config = lib.mkIf (cfg.enable) {
          environment.systemPackages = [ pkgs.bashmount ];

          services.udisks2.enable = true;
        };
      };
  };
}
