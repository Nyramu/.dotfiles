{ self, ... }:

let
  inherit (self.modules) nixos homeManager;
in
{
  hosts.main = {
    system = "x86_64-linux";
    cpu.vendor = "amd";
    gpu.integrated.vendor = "amd";
    bluetooth = {
      enable = true;
      useDongleOnly = true;
    };
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
        keyMap = "it2";
      };

      time.zone = "Europe/Rome";
    };

    # TODO: rework themes
    # theme = "just-chill";

    home =
      { pkgs, ... }:
      {
        imports = with homeManager; [
          stylix
          browsers
          desktops
          editors
          files
          gaming
          miscellaneous
          music
          services
          shells
          socials
          terminals
        ];

        nyra.desktops.hyprland = {
          enable = true;
          shader = {
            enable = false;
            name = "vibrant";
          };
          plugins = {
            dynamic-cursors.enable = true;
          };
          monitors = [
            {
              output = "eDP-1";
              mode = "1920x1200@60";
              position = "auto";
              scale = 1;
            }
          ];
        };

        nyra.socials = {
          telegram.enable = true;
          discord.enable = false;
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
          gimp.enable = false;
          aseprite.enable = false;
        };

        nyra.music = {
          spicetify.enable = true;
          rmpc.enable = true;
          spotiflac.enable = true;
          mpd.enable = true;
        };

        nyra.gaming = {
          minecraft.enable = true;
          lutris.enable = false;
          # heroic.enable = true; # Temporarily broken
          cemu = {
            enable = true;
            ukmm.enable = true;
          };
          eden.enable = true;
          azahar.enable = false;
        };

        nyra.miscellaneous = {
          btop = {
            enable = true;
            gpu-name = "Radeon 780M";
          };
          fastfetch.enable = true;
          packetTracer.enable = false;
        };

        nyra.stylix.enable = true;

        home.packages = with pkgs; [
          qbittorrent
          hyprpicker
          croc
          android-tools
          fontfor
          figlet
          cmatrix
          oxipng
          pngquant # pngquant is the best to drop below 1 MB
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
          gaming
          miscellaneous
          login
          services
        ];

        nyra.desktops = {
          hyprland.enable = true;
        };

        nyra.gaming = {
          steam.enable = true;
          gamemode.enable = true;
          gamescope.enable = true;
          lsfg.enable = true;
        };

        nyra.miscellaneous = {
          bashmount.enable = true;
        };

        nyra.services = {
          # Enable fingerprints support, register one running
          # fprintd-enroll <user>
          fingerprint.enable = true;
        };

        nyra.stylix.enable = true;

        # Use CachyOS latest Zen4 LTO kernel.
        boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-zen4;

        # Fix for Copilot button on Dell Inspiron
        services.keyd = {
          enable = true;
          keyboards = {
            dell-wmi = {
              ids = [ "*" ];
              settings = {
                main = {
                  "leftmeta+leftshift+f23" = "rightmeta";
                };
              };
            };
          };
        };
      };
  };
}
