{ config, ... }:

{
  programs.yazi = {
    keymap = {
      mgr.prepend_keymap = [
        # Keybinds
        {
          run = "cd ~/.dotfiles";
          on = [
            "g"
            "d"
          ];
          desc = "Go ~/.dotfiles";
        }
        {
          run = "cd /run/media/${config.nyra.settings.username}";
          on = [
            "g"
            "e"
          ];
          desc = "Go to external drives";
        }
        {
          run = "shell --block --interactive bashmount";
          on = [ "b" ];
          desc = "Open bashmount";
        }
        {
          run = "find --previous --smart";
          on = [ "\\" ];
          desc = "Find previous file";
        }
        {
          run = "yank --cut";
          on = [ "c" ];
          desc = "Yank selected files (cut)";
        }
        {
          run = "help";
          on = [ "?" ];
          desc = "Open help";
        }

        # Plugins keybinds
        {
          run = "plugin zoxide";
          on = [ "z" ];
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
          on = "x";
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
          on = [
            "g"
            "f"
          ];
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
  };
}
