{ pkgs, ... }:

{
  # Plugins dependencies
  home.packages =  with pkgs; [ python314 ];
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    oh-my-zsh = {
      enable = true;
      #theme = "yeknomhtooms";
      theme = "robbyrussell";
      plugins = [
        "colorize"
        "git"
        "gh"
        "git-prompt"
        "z"
        #"fz"
        "command-not-found"
        "copyfile"
        "copypath"
        "golang"
        "ssh"
        "thefuck"
      ];
    };
  };
}
