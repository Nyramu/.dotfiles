{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.modules.homeManager = {
    desktops.imports = [ self.modules.homeManager.hyprland ];

    hyprland =
      {
        config,
        pkgs,
        localization,
        wayland,
        ...
      }:

      let
        cfg = config.nyra.desktops.hyprland;
        shaderPath = self.outPath + "/resources/shaders/hyprland";
      in
      {
        imports = [
          inputs.hyprnix.homeModules.default
        ];

        config.hyprnix = {
          enable = cfg.enable;
          systemd.enable = true;
          xwayland.enable = wayland.xwayland.enable;
          settings = {
            monitors = cfg.monitors;
            render = {
              direct_scanout = 1;
              new_render_scheduling = true;
            };

            input = {
              kb_layout = localization.keyboard.layout;
              numlock_by_default = true;
              follow_mouse = 1;
              mouse_refocus = true;
              resolve_binds_by_sym = true;
              kb_options = "fkeys:basic_13-24";
            };

            cursor = {
              hyprcursor = {
                enable = true;
                package = pkgs.rose-pine-hyprcursor;
                name = "rose-pine-hyprcursor";
                size = 36;
              };
              inactive_timeout = 12;
              persistent_warps = true;
              warp_on_change_workspace = 0;
              hide_on_touch = true;
              hide_on_key_press = true;
            };

            binds = {
              workspace_center_on = 1;
            };

            ecosystem = {
              no_update_news = true;
              no_donation_nag = true;
            };

            general = {
              border_size = 2;
              resize_on_border = true;

              gaps_in = 5;
              gaps_out = 2;
              float_gaps = 2;

              layout = "dwindle";
              allow_tearing = false;

              snap = {
                enabled = true;
                respect_gaps = true;
              };
            };

            decoration = {
              rounding = 8;
              shadow = {
                range = 5;
                render_power = 3;
                # color = "rgba(26, 26, 26, 0.93)";
              };
              screen_shader = lib.mkIf (cfg.shader.enable) (shaderPath + "/${cfg.shader.name}.frag");
              blur = {
                enabled = true;
                new_optimizations = true;
                size = 1;
                passes = 2;
              };
              glow = {
                # enabled = true; # Somehow the option is broken on Hyprland
              };
            };

            dwindle.preserve_split = true;

            exec-once = [
              "noctalia-shell"
            ];

            exec = [
              "pkill .quickshell-wra ; noctalia-shell"
            ];

            misc = {
              disable_hyprland_logo = true;
              force_default_wallpaper = 0;
              animate_manual_resizes = true;
              enable_swallow = true;
              swallow_regex = "^(${config.nyra.terminals.default})$";
              session_lock_xray = true; # Should test with hyprlock or something
              animate_mouse_windowdragging = false; # Just lags for some reason
              vfr = false;
              vrr = 0;
            };
          };
        };

        options.nyra.desktops.hyprland = with lib; {
          enable = mkEnableOption "hyprland";

          monitors = mkOption {
            type = types.listOf types.attrs;
            default = [ ];
            description = "list of hyprland monitors";
          };

          shader = {
            enable = mkEnableOption "enable screen shader";
            name = mkOption {
              type = types.enum (builtins.readDir shaderPath |> builtins.attrNames);
            };
          };
        };
      };
  };

  flake.modules.nixos = {
    desktops.imports = [ self.modules.nixos.hyprland ];

    hyprland =
      {
        config,
        pkgs,
        wayland,
        ...
      }:

      let
        cfg = config.nyra.desktops.hyprland;
      in
      {
        options.nyra.desktops.hyprland = {
          enable = lib.mkEnableOption "hyprland";
        };

        config = {
          programs.hyprland = {
            enable = cfg.enable;
            package = pkgs.hyprland;
            xwayland.enable = wayland.xwayland.enable;
          };
        };
      };
  };
}
