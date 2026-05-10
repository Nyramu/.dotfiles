{
  inputs,
  config,
  lib,
  ...
}:

let
  inherit (lib)
    mkOption
    mkEnableOption
    mkDefault
    types
    mapAttrs
    ;

  # themeDir = self.outPath + "/modules/themes";
  # themeType = types.enum (builtins.readDir themeDir |> builtins.attrNames);

  hostType = types.submodule {
    options = {
      system = mkOption {
        type = types.str;
        default = "x86_64-linux";
      };

      cpu = {
        vendor = mkOption {
          type = types.enum [
            "amd"
            "intel"
          ];
        };
      };

      gpu = {
        integrated.vendor = mkOption {
          vendor = mkOption {
            type = types.enum [
              "amd"
              "intel"
            ];
          };
        };
        dedicated.vendor = mkOption {
          vendor = mkOption {
            type = types.enum [
              "amd"
              "nvidia"
            ];
          };
        };
      };

      audio = mkOption {
        type = types.nullOr (
          types.enum [
            "pulseaudio"
            "pipewire"
          ]
        );
        default = null;
      };

      bluetooth = {
        enable = mkOption {
          type = types.bool;
          default = true;
        };
        useDongleOnly = mkOption {
          type = types.bool;
          default = false;
          description = "disables internal Bluetooth forcing to use an external controller";
        };
      };

      shell = mkOption {
        type = types.enum [
          "bash"
          "zsh"
          "fish"
        ];
        default = "zsh";
      };

      wayland = {
        enable = mkOption {
          type = types.bool;
          default = true;
        };
        xwayland.enable = mkOption {
          type = types.bool;
          default = true;
        };
      };

      user = {
        name = mkOption {
          type = types.str;
          default = "nyramu";
        };

        description = mkOption {
          type = types.str;
          default = "Nyramu";
        };

        email = mkOption {
          type = types.str;
          default = "";
        };

        dotfiles = mkOption {
          type = types.str;
          default = "~/.dotfiles";
        };

        pfp = mkOption {
          type = types.path;
          default = ../../resources/pics/nyramu.png;
        };
      };

      localization = {
        keyboard = {
          layout = mkOption {
            type = types.str;
            example = "it";
          };

          variant = mkOption {
            type = types.str;
            default = "";
            example = "nodeadkeys";
          };

          keyMap = mkOption {
            type = types.str;
            default = "";
            example = "it2";
          };
        };

        time = {
          zone = mkOption {
            type = types.str;
            example = "America/New_York";
          };
          hardware-clock.enable = mkEnableOption "hardware clock (for dual boot)";
        };

        # theme = mkOption {
        #   type = themeType;
        # };
      };

      nixos = mkOption {
        type = types.deferredModule;
        default = { };
      };

      home = mkOption {
        type = types.deferredModule;
        default = { };
      };
    };
  };
in
{
  options.hosts = mkOption {
    type = types.attrsOf hostType;
    default = { };
  };

  config =
    let
      inherit (config.flake) modules;

      baseHost = rec {
        stateVersion = "26.05";

        nixos = {
          imports = with modules.nixos; [ core ];
          system.stateVersion = mkDefault stateVersion;
        };

        home = {
          imports = with modules.homeManager; [ core ];
          home.stateVersion = mkDefault stateVersion;
        };
      };
    in
    {
      flake.nixosConfigurations = mapAttrs (
        name: host:
        inputs.nixpkgs.lib.nixosSystem {
          modules = [
            baseHost.nixos
            host.nixos
          ];
          specialArgs = {
            inherit (host)
              audio
              bluetooth
              cpu
              gpu
              shell
              user
              localization
              wayland
              ;
            host = {
              inherit name;
              inherit (host) system;
            };
          };
        }
      ) config.hosts;

      flake.homeConfigurations = mapAttrs (
        name: host:
        inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import inputs.nixpkgs { system = host.system; };
          modules = [
            baseHost.home
            host.home
          ];
          extraSpecialArgs = {
            inherit (host)
              audio
              shell
              user
              localization
              wayland
              ;
            host = {
              inherit name;
              inherit (host) system;
            };
          };
        }
      ) config.hosts;
    };
}
