{ config, lib, ... }:

let
  cfg = config.nyra.shells;
in
{
  options.nyra.shells.zsh = {
    enable = lib.mkEnableOption "zsh";
  };

  config = {
    nyra.shells.zsh.enable = lib.mkDefault (cfg.default == "zsh");
    programs.zsh = {
      enable = cfg.zsh.enable;
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
          "golang"
          "ssh"
          "sudo"
        ];
      };
    };
  };
}
