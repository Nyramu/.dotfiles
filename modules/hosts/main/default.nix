{ self, ... }:

let
  inherit (self.modules) nixos homeManager;
in
{
  hosts.main = {
    system = "x86_64-linux";
    boot.splash = "hexagon_dots";

    cpu.vendor = "amd";
    gpu.integrated.vendor = "amd";

    bluetooth = {
      enable = true;
      useDongleOnly = true;
    };
    audio = "pipewire";

    user = {
      name = "nyramu";
      description = "Nyramu";
      email = "nyramu@noreply.codeberg.org";
    };
    shell = "zsh";

    localization = {
      keyboard = {
        layout = "it";
        keyMap = "it2";
      };

      time.zone = "Europe/Rome";
    };

    theme = "lanterns";

    home =
      { pkgs, ... }:
      {
        imports = with homeManager; [
          browsers
          desktops
          productivity
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
          # discord.enable = true;
        };

        nyra.terminals = {
          default = "kitty";
        };

        nyra.browsers.default = "zen-twilight";
        nyra.files.default = "yazi";

        nyra.productivity = {
          helix.enable = true;
          blanket.enable = true;
          intellij.enable = true;
          # zed.enable = true;
          # gimp.enable = true;
          # aseprite.enable = true;
          # packetTracer.enable = true;
        };

        nyra.music = {
          spicetify.enable = true;
          rmpc.enable = true;
          spotiflac.enable = true;
        };

        nyra.gaming = {
          minecraft.enable = true;
          # lutris.enable = true;
          # heroic.enable = true; # Temporarily broken
          cemu = {
            enable = true;
            ukmm.enable = true;
          };
          eden.enable = true;
          # azahar.enable = true;
        };

        nyra.miscellaneous = {
          btop = {
            enable = true;
            gpu-name = "Radeon 780M";
          };
          fastfetch.enable = true;
        };

        home.packages = with pkgs; [
          qbittorrent
          hyprpicker
          croc
          android-tools
          fontfor
          figlet
          cbonsai
          pipes-rs
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
          # httpd.enable = true;
          # mysql.enable = true;
        };

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
