{ self, ... }:
{
  flake.modules.homeManager = {
    miscellaneous.imports = [ self.modules.homeManager.java ];

    java =
      {
        config,
        lib,
        pkgs,
        ...
      }:

      let
        cfg = config.nyra.miscellaneous.java;
      in
      {
        options.nyra.miscellaneous.java = {
          enable = lib.mkEnableOption "java";
          package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.openjdk25;
          };
        };

        config = lib.mkIf (cfg.enable) {
          programs.java = {
            enable = true;
            package = cfg.package;
          };
        };
      };
  };
}
