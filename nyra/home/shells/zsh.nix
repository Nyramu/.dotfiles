{ config, lib, pkgs, ... }: with lib;

let
  # Fetch theme
  yeknomhtooms-theme = pkgs.fetchFromGitHub {
    owner = "sebastianpulido";
    repo = "oh-my-zsh";
    rev = "master";
    sha256 = "sha256-1gcdHxDNWAv8CeAWWE1CPzSZuVr59gn4fTHaQlHAm6o=";
  };

  cfg = config.nyra.home.shells.zsh; 
in
{
  options.nyra.home.shells.zsh = {
    enable = mkEnableOption "zsh";
  };

  config = {
    programs.zsh = {
      enable = cfg.enable;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      oh-my-zsh = {
        enable = true;
        #theme = "robbyrussell";
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
        source ${yeknomhtooms-theme}/smoothmonkey.zsh-theme
      '';
    };  
  };
}
