{
  config,
  lib,
  pkgs,
  ...
}:

let
  # Fetch themes
  nyra = pkgs.fetchFromGitHub {
    owner = "Nyramu";
    repo = "nyra-zsh";
    rev = "main";
    sha256 = "sha256-90E//A3RaE2Z80rrxLLq/bEZm2K/oKShVDciaOq2N+A=";
  };
  theme-path = { nyra = "${nyra}/nyra.zsh-theme"; }.${cfg.theme};

  cfg = config.nyra.home.shells.zsh;
in
{
  options.nyra.home.shells.zsh = {
    enable = lib.mkEnableOption "zsh";
    theme = lib.mkOption {
      type = lib.types.enum [ "nyra" ];
      default = "nyra";
      description = "choose zsh theme";
    };
  };

  config = {
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

      initContent = ''
        # Set theme
        source ${theme-path}
      '';
    };
  };
}
