{ config, lib, pkgs, ... }: with lib;

let
  # Fetch themes
  yeknomhtooms = pkgs.fetchFromGitHub {
    owner = "sebastianpulido";
    repo = "oh-my-zsh";
    rev = "master";
    sha256 = "sha256-1gcdHxDNWAv8CeAWWE1CPzSZuVr59gn4fTHaQlHAm6o=";
  };
  jovial = pkgs.fetchFromGitHub {
    owner = "zthxxx";
    repo = "jovial";
    rev = "master";
    sha256 = "sha256-MxejCd58je1bIc0+IDn1brG1kxVWS0we2sT0wiPRr4c=";
  };
  nyra = pkgs.fetchFromGitHub {
    owner = "Nyramu";
    repo = "nyra-zsh";
    rev = "main";
    sha256 = "sha256-90E//A3RaE2Z80rrxLLq/bEZm2K/oKShVDciaOq2N+A=";
  };
  theme-path = {
    yeknomhtooms = "${yeknomhtooms}/smoothmonkey.zsh-theme";
    jovial = "${jovial}/jovial.zsh-theme";
    nyra = "${nyra}/nyra.zsh-theme";
  }.${cfg.theme};

  cfg = config.nyra.home.shells.zsh; 
in
{
  options.nyra.home.shells.zsh = {
    enable = mkEnableOption "zsh";
    theme = mkOption {
      type = types.enum [ "yeknomhtooms" "jovial" "nyra" ];
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
