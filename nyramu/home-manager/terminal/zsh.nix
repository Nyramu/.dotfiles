{ pkgs, ... }:

let
  # Fetch theme
  yeknomhtooms-theme = pkgs.fetchFromGitHub {
    owner = "sebastianpulido";
    repo = "oh-my-zsh";
    rev = "master";
    sha256 = "sha256-1gcdHxDNWAv8CeAWWE1CPzSZuVr59gn4fTHaQlHAm6o=";
  };
in
{
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    oh-my-zsh = {
      enable = true;
      #theme = "robbyrussell";
      plugins = [
        "colorize"
        "git"
        "gh"
        "git-prompt"
        "z"
        "command-not-found"
        "copyfile"
        "copypath"
        "golang"
        "ssh"
      ];
    };
    
    initContent = ''
      # Set theme
      source ${yeknomhtooms-theme}/smoothmonkey.zsh-theme
    '';
  };

  # pay-respects integration
  programs.pay-respects = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--alias f" "--alias fuck" ];
  };
}
