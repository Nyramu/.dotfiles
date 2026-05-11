{ self, lib, ... }:
{
  flake.modules.homeManager = {
    editors.imports = [ self.modules.homeManager.helix ];

    helix =
      { config, ... }:

      let
        cfg = config.nyra.editors.helix;
      in
      {
        options.nyra.editors.helix = {
          enable = lib.mkEnableOption "helix";
        };

        config = lib.mkIf (cfg.enable) {
          programs.helix = {
            enable = true;
            defaultEditor = true;

            settings = {
              editor = {
                auto-format = true;
                line-number = "relative";
                bufferline = "multiple";
                color-modes = true;
                popup-border = "all";
                continue-comments = false;
                smart-tab.enable = false;

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
        };
      };
  };
}
