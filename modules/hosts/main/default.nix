{ ... }:

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

        nyra.editors = {
          default = "helix";
          # idea.enable = true;
        };

        nyra.productivity = {
          blanket.enable = true;
          # gimp.enable = true;
        };

        nyra.music = {
          spicetify.enable = true;
          rmpc.enable = true;
          spotiflac.enable = true;
        };

        nyra.gaming = {
          minecraft.enable = true;
          cemu = {
            enable = true;
            ukmm.enable = true;
          };
          eden.enable = true;
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
          # figlet
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

        # Enable fingerprints support, register one running
        # fprintd-enroll <user>
        nyra.services.fingerprint.enable = true;

        # Use CachyOS latest Zen4 LTO kernel.
        boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-zen4;

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
