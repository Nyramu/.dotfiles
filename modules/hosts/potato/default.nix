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
      email = "107689027+Nyramu@users.noreply.github.com";
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

    # theme = "just-chill";

    home =
      { pkgs, ... }:
      {
        imports = with homeManager; [
          stylix
          desktops
          terminals
          miscellaneous
          browsers
          services
          editors
          login
          files
        ];

        nyra.desktops.hyprland = {
          enable = true;
          dynamic-cursors.enable = true;
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

        nyra.editors = {
          helix.enable = true;
          intellij.enable = false;
          zed.enable = false;
        };

        nyra.miscellaneous = {
          btop = {
            enable = true;
            gpu-name = "Radeon R8 M445DX";
          };
          fastfetch.enable = true;
          packetTracer.enable = false;
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
          stylix
          desktops
          services
          login
        ];

        nyra.services = {
          mysql.enable = true;
          httpd.enable = true;
        };

        # Use CachyOS Latest v3 LTO kernel.
        boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;
      };
  };
}
