{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      background-blur = false;
      working-directory = "inherit";
      confirm-close-surface = false;
      right-click-action = "copy-or-paste";
      clipboard-read = "allow";
      clipboard-write = "allow";
      clipboard-paste-protection = false;
    };
  };
}
