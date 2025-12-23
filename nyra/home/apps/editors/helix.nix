{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.home.apps.editors.helix;

  helix-wrapped = pkgs.writeShellScriptBin "hx" ''
    if [ -z "$ZELLIJ" ]; then
      LAYOUT=$(mktemp --suffix=.kdl)
      cat > "$LAYOUT" <<EOF
    layout {
      pane command="${pkgs.helix}/bin/hx" {
        args "$@"
        close_on_exit true
      }
    }
    EOF
      ${pkgs.zellij}/bin/zellij \
        --layout "$LAYOUT"
      rm -f "$LAYOUT"
    else
      exec ${pkgs.helix}/bin/hx "$@"
    fi
  '';
in {
  options.nyra.home.apps.editors.helix = {
    enable = mkEnableOption "helix";
  };

  config = {
    programs.helix = {
      enable = cfg.enable;
      package = helix-wrapped;
      defaultEditor = true;

      settings = {
        editor = {
          auto-format = true;
          line-number = "relative";
          bufferline = "multiple";
          color-modes = true;
          popup-border = "all";

          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };

          statusline = {
            left = ["mode" "spacer" "file-name" "read-only-indicator" "file-modification-indicator"];
            center = ["version-control"];
            right = ["spinner" "file-type" "diagnostics" "position" "position-percentage"];
          };
          
          lsp = {
            display-progress-messages = true;
            display-inlay-hints = true;
          };

          auto-save = {
            focus-lost = true;
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

        keys.normal = {
          C-q = ":wq";
          C-s = ":w";
          C-f = ":fmt";
          C-w = ":buffer-close";
          C-W = ":write-buffer-close";
          C-right = ":buffer-next";
          C-left = ":buffer-previous";

          space.g.g = ":sh zellij run -c -f -x 10%% -y 10%% --width 80%% --height 80%% -- ${getExe pkgs.lazygit}";
        };
      };

      languages = {
        language-server = {
          nil.command = "${getExe pkgs.nil}";
          bash-language-server.command = "${getExe pkgs.bash-language-server}";
          clangd.command = "${pkgs.clang-tools}/bin/clangd";
          cmake-language-server.command = "${getExe pkgs.cmake-language-server}";
          csharp-ls.command = "${getExe pkgs.csharp-ls}";
          #elixir-ls.command = "${getExe pkgs.elixir-ls}";
          #kotlin-language-server.command = "${getExe pkgs.kotlin-language-server}";
          markdown-oxide.command = "${getExe pkgs.markdown-oxide}";
          #rust-analyzer.command = "${getExe pkgs.rust-analyzer}";
          vscode-css-language-server.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server";
          typescript-language-server = {
            command = "${getExe pkgs.typescript-language-server}";
            config = {
              typescript.inlayHints = {
                includeInlayEnumMemberValueHints = true;
                includeInlayFunctionLikeReturnTypeHints = false;
                includeInlayFunctionParameterTypeHints = false;
                includeInlayParameterNameHints = "literals";
                includeInlayParameterNameHintsWhenArgumentMatchesName = true;
                includeInlayPropertyDeclarationTypeHints = false;
                includeInlayVariableTypeHints = true;
              };
            };
          };
        };

        language = [
          {
            name = "nix";
            file-types = ["nix"];
            formatter.command = "${getExe pkgs.alejandra}";
          }
        ];
      };
    };
  };
}
