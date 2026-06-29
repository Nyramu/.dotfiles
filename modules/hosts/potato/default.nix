{ ... }:

{
  hosts.potato = {
    system = "x86_64-linux";
    cpu.vendor = "amd";
    gpu.integrated.vendor = "amd";
    bluetooth.enable = true;
    audio = "pipewire";

    user = {
      name = "arami";
      description = "Arami";
    };
    shell = "zsh";

    localization = {
      keyboard = {
        layout = "it";
        keyMap = "it";
      };

      time.zone = "Europe/Rome";
    };

    performance = "potato";

    home =
      { pkgs, ... }:
      {
        nyra.desktops.hyprland = {
          enable = true;
          shader = {
            enable = true;
            name = "less-saturation";
          };
          monitors = [
            {
              output = "eDP-1";
              mode = "1920x1080@60";
              position = "auto";
              scale = 1;
            }
          ];
        };

        nyra.terminals.default = "kitty";
        nyra.browsers.default = "zen-twilight";
        nyra.files.default = "yazi";
        nyra.editors.default = "helix";

        nyra.miscellaneous = {
          btop = {
            enable = true;
            gpu-name = "Radeon R8 M445DX";
          };
          fastfetch.enable = true;
        };

        home.packages = with pkgs; [
          croc
          wev
        ];
      };

    nixos =
      { pkgs, ... }:
      {
        nyra.desktops = {
          hyprland.enable = true;
        };

        nyra.miscellaneous = {
          bashmount.enable = true;
        };

        i18n = {
          defaultLocale = "it_IT.UTF-8";
          extraLocaleSettings = { };
        };

        # Use CachyOS Latest v3 LTO kernel.
        boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;
      };
  };
}
