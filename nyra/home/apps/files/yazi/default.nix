{
  config,
  lib,
  pkgs,
  ...
}:

let
  shells = config.nyra.shells;
  cfg = config.nyra.apps.files;
in
{
  imports = [
    ./keybinds.nix
    ./open-rules.nix
  ];

  options.nyra.apps.files.yazi = {
    enable = lib.mkEnableOption "yazi";
  };

  config = {
    nyra.apps.files.yazi.enable = lib.mkDefault (cfg.default == "yazi");
    programs.yazi = {
      enable = cfg.yazi.enable;
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
