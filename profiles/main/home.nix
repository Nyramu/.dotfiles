{ ... }:

{
  imports = [
    ../base/home.nix
  ];

  # Theming
  nyra.theme = {
    enable = true;
    defaultTheme = "pixel-sunset";
  };

  # Apps
  nyra.home.apps = {
    terminals = {
      default = "kitty";
      alacritty.enable = true;
    };
    editors = {
      nvf.enable = true;
    };
    browsers = {
      #default = "zen"; # Idk why it explodes if configured
      qutebrowser.enable = true;
    };
    socials = {
      telegram.enable = true;
      discord.enable = true;
    };
    miscellaneous = {
      btop.enable = true;
      fastfetch.enable = true;
    };
  };

  # Shells and commands
  nyra.home.shells = {
    zsh.enable = true;
    commands = {
      pay-respects.enable = true;
    };
  };

  nyra.home.desktops.hyprland.enable = true;
}
