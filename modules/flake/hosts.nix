{
  self,
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

  themeType = types.enum (builtins.readDir (self.outPath + "/modules/themes") |> builtins.attrNames);

  hostType = types.submodule (
    { config, ... }: {
      options = {
        system = mkOption {
          type = types.str;
          default = "x86_64-linux";
        };

        boot = {
          silent = lib.mkOption {
            type = types.bool;
            default = (config.boot.splash != null);
          };
          splash = lib.mkOption {
            type = types.nullOr types.str;
            default = null;
            description = "Splash from adi1090x plymouth themes.";
            example = "hexagon_dots";
          };
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
          integrated = {
            vendor = mkOption {
              type = types.enum [
                "amd"
                "intel"
              ];
            };
          };
          dedicated = {
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
            default = "/home/${config.user.name}/.dotfiles";
          };

          pfp = mkOption {
            type = types.path;
            default = config.user.dotfiles + "/resources/pics/nyramu.png";
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
        };

        theme = mkOption {
          type = types.nullOr themeType;
        };

        performance = mkOption {
          type = types.enum [
            "potato"
            "normal"
          ];
          default = "normal";
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
    }
  );
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
        stateVersion = "26.11";

        nixos = {
          imports = with modules.nixos; [
            core
          ];
          system.stateVersion = mkDefault stateVersion;
        };

        home = {
          imports = with modules.homeManager; [
            core
          ];
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
            "${self.outPath}/modules/hosts/${name}/_hardware-configuration.nix"
            self.modules.nixos.nyra
          ];
          specialArgs = {
            inherit (host)
              theme
              boot
              audio
              bluetooth
              cpu
              gpu
              shell
              user
              localization
              performance
              wayland
              ;
            host = {
              inherit name;
              inherit (host) system;
            };

            dotpkgs = self.packages.${host.system};
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
            self.modules.homeManager.nyra
          ];
          extraSpecialArgs = {
            inherit (host)
              theme
              audio
              shell
              user
              localization
              performance
              wayland
              ;
            host = {
              inherit name;
              inherit (host) system;
            };

            dotpkgs = self.packages.${host.system};
          };
        }
      ) config.hosts;
    };
}
