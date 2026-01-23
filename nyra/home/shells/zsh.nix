{ config, ... }:

let
  cfg = config.nyra.shells.zsh;
in
{
  programs.zsh = {
    enable = cfg.enable;
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
        #"git-commit"
        "git-prompt"
        "golang"
        "ssh"
        "sudo"
      ];
    };
  };
}
