{ ... }:

{
  # Theming
  nyra.theme = {
    enable = true;
    defaultTheme = "just-chill"; # just-chill | red-eclipse | apocalypse
  };

  # Common settings
  nyra.audio.server = "pipewire";
  nyra.shells = {
    defaultShell = "zsh";
    nushell.enable = false;
  };
  nyra.desktops = {
    hyprland = {
      enable = true;
      monitors = [
        "eDP-1, 1920x1080@60, auto, 1"
      ];
    };
  };

  # User and System settings
  nyra.settings = {
    hostname = "nixos";
    username = "nyramu";
    name = "Nyramu";
    email = "107689027+Nyramu@users.noreply.github.com";
    dotfiles = "~/.dotfiles";
  };
}
