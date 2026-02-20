{
  config,
  lib,
  pkgs,
  ...
}:

let
  shells = config.nyra.shells;
  defaultFileManager = config.nyra.home.apps.defaultFileManager;
  cfg = config.nyra.home.apps.yazi;
in
{
  imports = [
    ./keybinds.nix
    ./open-rules.nix
  ];

  options.nyra.home.apps.yazi = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = defaultFileManager == "yazi";
      description = "yazi";
    };
  };

  config = {
    programs.yazi = {
      enable = cfg.enable;
      enableZshIntegration = shells.zsh.enable;
      enableNushellIntegration = shells.nushell.enable;
      settings = {
        mgr = {
          sort_by = "alphabetical";
          sort_sensitive = false;
          sort_dir_first = true;
          sort_reverse = false;
          show_symlink = true;
          linemode = "none";
          show_hidden = false;
        };
        preview.wrap = "yes";
        opener = {
          xdg = [
            {
              run = ''xdg-open "$@"'';
              block = true;
            }
          ];
        };
        input.cursor_blink = true;
      };
      plugins = with pkgs.yaziPlugins; {
        inherit full-border;
      };
      initLua = ''
        require("full-border"):setup {
         type = ui.Border.ROUNDED,
        }
      '';
    };
  };
}
