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
          enable = lib.mkEnableOption "zsh" // {
            default = (shell == "zsh");
            defaultText = lib.literalExpression "host.shell == \"zsh\"";
          };
        };

        config = lib.mkIf (cfg.enable) {
          programs.zsh = {
            enable = true;
            syntaxHighlighting.enable = true;
            autosuggestion.enable = true;
            dotDir = "${config.xdg.configHome}/zsh";
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
        };
      };
  };
}
