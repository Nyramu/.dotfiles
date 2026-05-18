{ self, ... }:

let
  inherit (self.modules) nixos homeManager;
in
{
  hosts.potato = {
    system = "x86_64-linux";
    cpu.vendor = "amd";
    gpu.integrated.vendor = "amd";
    bluetooth.enable = true;
    audio = "pipewire";

    user = rec {
      name = "nyramu";
      description = "Nyramu";
      email = "nyramu@noreply.codeberg.org";
      dotfiles = "/home/${name}/.dotfiles";
    };
    shell = "zsh";

    localization = {
      keyboard = {
        layout = "it";
        keyMap = "it";
      };

      time.zone = "Europe/Rome";
    };

    home =
      { pkgs, ... }:
      {
        imports = with homeManager; [
          browsers
          desktops
          productivity
          files
          miscellaneous
          services
          shells
          terminals
        ];

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

        nyra.terminals = {
          default = "kitty";
          ghostty.enable = true;
        };

        nyra.browsers.default = "zen-twilight";
        nyra.files.default = "yazi";

        nyra.productivity = {
          helix.enable = true;
          packetTracer.enable = false;
        };

        nyra.miscellaneous = {
          btop = {
            enable = true;
            gpu-name = "Radeon R8 M445DX";
          };
          fastfetch.enable = true;
        };

        home.packages = with pkgs; [
          figlet
          hyprpicker
          croc
          fontfor
          wev
        ];
      };

    nixos =
      { pkgs, ... }:

      {
        imports = with nixos; [
          ./_hardware-configuration.nix
          desktops
          miscellaneous
          login
          services
        ];

        nyra.desktops = {
          hyprland.enable = true;
        };

        nyra.services = {
          mysql.enable = true;
          httpd.enable = true;
        };

        nyra.miscellaneous = {
          bashmount.enable = true;
        };

        # Use CachyOS Latest v3 LTO kernel.
        boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;
      };
  };
}
