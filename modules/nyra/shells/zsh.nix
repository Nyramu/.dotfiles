{ self, lib, ... }:
{
  flake.modules.homeManager = {
    shells.imports = [ self.modules.homeManager.zsh ];

    zsh =
      { config, shell, ... }:

      let
        cfg = config.nyra.shells.zsh;
      in
      {
        options.nyra.shells.zsh = {
          enable = lib.mkEnableOption "zsh";
        };

        config = {
          programs.zsh = lib.mkIf (cfg.enable) {
            enable = true;
            syntaxHighlighting.enable = true;
            autosuggestion.enable = true;
            oh-my-zsh = {
              enable = true;
              plugins = [
                "alias-finder"
                "colored-man-pages"
                "colorize"
                "copyfile"
                "fancy-ctrl-z"
                "git"
                "gh"
                "golang"
                "ssh"
                "sudo"
              ];
            };
          };
          nyra.shells.zsh.enable = lib.mkDefault (shell == "zsh");
        };
      };
  };
}
