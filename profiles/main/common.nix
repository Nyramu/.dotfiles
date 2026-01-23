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
    nushell.enable = true;
  };
  nyra.desktops = {
    hyprland.enable = true;
  };
}
