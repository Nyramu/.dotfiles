{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  shellCfg = config.nyra.home.shells;
  cfg = config.nyra.home.apps.miscellaneous.yazi;
in {
  options.nyra.home.apps.miscellaneous.yazi = {
    enable = mkEnableOption "yazi";
  };

  config = {
    programs.yazi = {
      enable = cfg.enable;
      enableZshIntegration = shellCfg.zsh.enable;
      settings = {
        mgr = {
          sort_by = "none";
          sort_sensitive = false;
          sort_dir_first = true;
          sort_reverse = false;
          linemode = "none";
          show_hidden = false;
        };
        preview.wrap = "yes";
        opener.edit = [
          {
            "run" = "$EDITOR \"$@\"";
            "block" = true;
          }
        ];
        input.cursor_blink = true;
        # plugin.prepend_previewers = [
        #   {
        #     name = "*.csv";
        #     run = "rich-preview";
        #   }
        #   {
        #     name = "*.md";
        #     run = "piper -- CLICOLOR_FORCE=1 glow -w=$w -s=dark \"''$1\"";
        #   }
        #   {
        #     name = "*.rst";
        #     run = "rich-preview";
        #   }
        #   {
        #     name = "*.ipynb";
        #     run = "rich-preview";
        #   }
        #   {
        #     name = "*.json";
        #     run = "rich-preview";
        #   }
        # ];
      };
      keymap = {
        mgr.prepend_keymap = [
          # Keybinds
          {
            run = "cd ~/.dotfiles";
            on = ["g" "d"];
            desc = "Go ~/.dotfiles";
          }
          {
            run = "find --previous --smart";
            on = ["\\"];
            desc = "Find previous file";
          }
          {
            run = "help";
            on = ["?"];
            desc = "Open help";
          }

          # Plugins keybinds
          {
            run = "plugin zoxide";
            on = ["z"];
            desc = "Jump to a directory via zoxide";
          }

          # Tabs keybinds
          {
            run = "tab_create --current";
            on = "<C-Enter>";
            desc = "Create a new tab with CWO";
          }
          {
            run = "close";
            on = "<C-Backspace>";
            desc = "Close the current tab, or quit if it's last";
          }
          {
            run = "tab_switch -1 --relative";
            on = "<C-Left>";
            desc = "Switch to previous tab";
          }
          {
            run = "tab_switch --relative 1";
            on = "<C-Right>";
            desc = "Switch to next tab";
          }

          # Disable preset keybinds
          {
            run = "noop";
            on = "t";
          }
          {
            run = "noop";
            on = "[";
          }
          {
            run = "noop";
            on = "]";
          }
          {
            run = "noop";
            on = ["g" "f"];
          }
          {
            run = "noop";
            on = "Z";
          }
          {
            run = "noop";
            on = "<C-c>";
          }
        ];
      };
      plugins = with pkgs.yaziPlugins; {
        inherit full-border;
        # inherit piper;
      };
      initLua = ''
        require("full-border"):setup {
         type = ui.Border.ROUNDED,
        }
      '';
    };
    # home.packages = with pkgs; [glow];
  };
}
