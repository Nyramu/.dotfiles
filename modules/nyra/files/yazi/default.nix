{ self, lib, ... }:
{
  flake.modules.homeManager = {
    files.imports = [ self.modules.homeManager.yazi ];

    yazi =
      {
        config,
        shell,
        pkgs,
        ...
      }:

      let
        cfg = config.nyra.files.yazi;
        default = config.nyra.files.default;
      in
      {
        options.nyra.files.yazi = {
          enable = lib.mkEnableOption "yazi";
        };

        config = {
          programs.yazi = lib.mkIf (cfg.enable) {
            enable = true;
            enableBashIntegration = (shell == "bash");
            enableZshIntegration = (shell == "zsh");
            enableFishIntegration = (shell == "fish");
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
          nyra.files.yazi.enable = lib.mkDefault (default == "yazi");

          hyprnix.settings.bind = lib.mkIf (config.nyra.desktops.hyprland.enable && default == "yazi") {
            "SUPER + E".dispatcher.exec_cmd = "${config.nyra.terminals.default} -e yazi";
          };
        };
      };
  };
}
