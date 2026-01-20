{
  config,
  lib,
  pkgs,
  ...
}: let

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
  options.nyra.home.apps.helix = {
    enable = lib.mkEnableOption "helix";
  };

  config = {
    programs.helix = {
      enable = config.nyra.home.apps.helix.enable;
      package = helix-wrapped;
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
            insert = "bar";
            select = "underline";
          };

          soft-wrap = {
            enable = true;
            max-wrap = 25;
          };

          statusline = {
            left = ["mode" "spacer" "file-name" "read-only-indicator" "file-modification-indicator"];
            center = ["version-control"];
            right = ["spinner" "file-type" "diagnostics" "position" "position-percentage"];
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

        keys.normal = {
          A-q = ":write-quit"; # Save and quit Helix
          A-s = ":write"; # Save
          A-f = ":format"; # Format code
          A-r = "replace_selections_with_clipboard"; # Replace selection with clipboard content
          A-p = "paste_clipboard_before"; # Paste clipboard content before selection
          A-y = "yank_to_clipboard"; # Yank selection to clipboard
          A-d = "delete_selection"; # Delete selection
          A-c = ["yank_to_clipboard" "delete_selection"]; # Cut selection
          A-n = ":new"; # New file from scratch

          A-esc = ":buffer-close!"; # Force close current file
          A-ret = ":write-buffer-close"; # Save and close current file
          A-right = ":buffer-next"; # Go to the next opened file
          A-left = ":buffer-previous"; # Go to the previous opened file

          C-z = "undo"; # Undo changes
          C-y = "redo"; # Redo changes
          C-f = "search"; # Search regex
          C-right = "search_next"; # Select next search match
          C-left = "search_prev"; # Select previous search match

          space = {
            g = ":sh zellij run -c -f -x 10%% -y 10%% --width 80%% --height 80%% -- ${lib.getExe pkgs.lazygit}";
            d = [":cd ~/.dotfiles" "file_picker"];
            s = "global_search";
            f = "file_picker";
          };

          A-up = "no_op";
          A-down = "no_op";
          space."/" = "no_op";
        };

        keys.insert = {
          A-r = "replace_selections_with_clipboard"; # Replace selection with clipboard content
          A-p = "paste_clipboard_before"; # Paste clipboard content before selection
          A-y = "yank_to_clipboard"; # Yank selection to clipboard
          A-d = "delete_selection"; # Delete selection
          A-c = ["yank_to_clipboard" "delete_selection"]; # Cut selection

          C-d = "kill_to_line_start"; # Delete till start of line
          C-z = "undo"; # Undo changes
          C-y = "redo"; # Redo changes
          C-f = "search"; # Search regex
          C-right = "search_next"; # Select next search match
          C-left = "search_prev"; # Select previous search match
          C-space = "toggle_comments"; # Comment/uncomment current line or selection

          S-ret = "insert_newline";

          A-right = "move_next_word_end"; # Move to end of next word
          A-left = "move_prev_word_start"; # Move to start of previous word
          A-up = "move_visual_line_up"; # Move up
          A-down = "move_visual_line_down"; # Move down

          S-right = "extend_char_right"; # Extend to right
          S-left = "extend_char_left"; # Extend to left
          S-up = "extend_visual_line_up"; # Extend up
          S-down = "extend_visual_line_down"; # Extend down

          S-A-right = "extend_next_word_start"; # Extend to start of next word
          S-A-left = "extend_prev_word_start"; # Extend to start of previous word
          S-A-up = "extend_visual_line_up"; # Extend up
          S-A-down = "extend_visual_line_down"; # Extend down
        };

        keys.select = {
          S-right = "extend_next_word_start"; # Extend to start of next word
          S-left = "extend_prev_word_start"; # Extend to start of previous word

          C-space = "toggle_comments"; # Comment/uncomment current line or selection
        };
      };

      languages = {
        language-server = {
          nixd.command = "${lib.getExe pkgs.nixd}";
          nil.command = "${lib.getExe pkgs.nil}";
          bash-language-server.command = "${lib.getExe pkgs.bash-language-server}";
          clangd.command = "${pkgs.clang-tools}/bin/clangd";
          cmake-language-server.command = "${lib.getExe pkgs.cmake-language-server}";
          csharp-ls.command = "${lib.getExe pkgs.csharp-ls}";
          #kotlin-language-server.command = "${getExe pkgs.kotlin-language-server}";
          gopls.command = "${lib.getExe pkgs.gopls}";
          intelephense.command = "${lib.getExe pkgs.intelephense}"; # PHP
          superhtml.command = "${lib.getExe pkgs.superhtml}";
          markdown-oxide.command = "${lib.getExe pkgs.markdown-oxide}";
          vscode-css-language-server.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server";
          typescript-language-server = {
            command = "${lib.getExe pkgs.typescript-language-server}";
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
            formatter.command = "${lib.getExe pkgs.alejandra}";
          }
        ];
      };
    };
  };
}
