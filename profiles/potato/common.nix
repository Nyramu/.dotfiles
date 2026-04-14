{ ... }:

{
  # Theming
  nyra.theme = {
    enable = true;
    name = "just-chill"; # just-chill | red-eclipse | apocalypse
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
        {
          output = "eDP-1";
          mode = "1920x1080@60";
          position = "auto";
          scale = 1;
        }
      ];
      shader = {
        enable = true;
        name = "less-saturation";
      };
      dynamic-cursors = {
        enable = true;
      };
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
