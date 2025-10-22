{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      background-opacity = 0.6;
      background-blur = false;
      working-directory = "inherit";
    };
  };
}
