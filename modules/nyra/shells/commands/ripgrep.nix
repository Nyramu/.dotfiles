{ self, lib, ... }:
{
  flake.modules.homeManager = {
    shells.commands.imports = [ self.modules.homeManager.ripgrep ];

    ripgrep =
      { config, ... }:

      let
        cfg = config.nyra.shells.commands.ripgrep;
      in
      {
        options.nyra.shells.commands.ripgrep = {
          enable = lib.mkOption {
            type = lib.types.bool;
            default = true;
          };
        };

        config = lib.mkIf (cfg.enable) {
          programs.ripgrep = {
            enable = true;
            arguments = [
              "--smart-case"
              "--max-columns=150"
              "--max-columns-preview"
            ];
          };
          home.shellAliases = {
            "grep" = "rg";
          };
        };
      };
  };
}
