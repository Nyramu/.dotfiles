{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.modules.homeManager = {
    editors.imports = [ self.modules.homeManager.helix ];

    helix =
      {
        config,
        nyralib,
        pkgs,
        host,
        ...
      }:

      let
        cfg = config.nyra.editors.helix;
        helix = if (cfg.unstable) then inputs.chaotic.packages.${host.system}.helix_git else pkgs.helix;
      in
      {
        options.nyra.editors.helix = {
          enable = nyralib.mkDefaultDependentOption "Helix" "nyra.editors.default" "helix";
          unstable = lib.mkEnableOption "" // {
            description = "Use Helix git version";
          };
        };

        config = lib.mkIf (cfg.enable) {
          programs.helix = {
            enable = true;
            package = helix;
            defaultEditor = (config.nyra.editors.default == "helix");

            settings = {
              editor = {
                auto-format = true;
                line-number = "absolute";
                bufferline = "multiple";
                mouse = true;
                color-modes = true;
                popup-border = "all";
                continue-comments = false;
                smart-tab.enable = true;

                cursor-shape = {
                  normal = "block";
                  insert = "block";
                  select = "underline";
                };

                soft-wrap = {
                  enable = true;
                  max-wrap = 25;
                };

                statusline = {
                  left = [
                    "mode"
                    "spacer"
                    "file-name"
                    "read-only-indicator"
                    "file-modification-indicator"
                  ];
                  center = [ "version-control" ];
                  right = [
                    "spinner"
                    "file-type"
                    "diagnostics"
                    "position"
                    "position-percentage"
                  ];
                  mode.normal = "NORMAL";
                  mode.insert = "INSERT";
                  mode.select = "SELECT";
                };

                lsp = {
                  display-progress-messages = true;
                  display-inlay-hints = true;
                };

                auto-save = {
                  focus-lost = true;
                  after-delay.enable = false; # 3000 ms, add after-delay.timeout to change
                };

                indent-guides = {
                  render = true;
                  character = "▏";
                  skip-levels = 1;
                };

                inline-diagnostics = {
                  cursor-line = "hint";
                  other-lines = "warning";
                };
              };
            };
          };

          hyprnix.settings.bind = lib.mkIf (config.nyra.desktops.hyprland.enable) {
            "SUPER + BACKSPACE".dispatcher.exec_cmd = "${config.nyra.terminals.default} -e hx";
            "SUPER + ALT + BACKSPACE".dispatcher.exec_cmd =
              "${config.nyra.terminals.default} --class floating-${config.nyra.terminals.default} -e hx";
          };
        };
      };
  };
}
