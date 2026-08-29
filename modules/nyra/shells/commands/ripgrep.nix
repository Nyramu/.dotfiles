{ self, lib, ... }:
{
  flake.modules.homeManager = {
    shells.imports = [ self.modules.homeManager.ripgrep ];

    ripgrep =
      { config, nyralib, ... }:

      let
        cfg = config.nyra.shells.commands.ripgrep;
      in
      {
        options.nyra.shells.commands.ripgrep = {
          enable = nyralib.mkEnabledOption "ripgrep";
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
