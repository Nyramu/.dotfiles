{ self, lib, ... }:
{
  flake.modules.homeManager = {
    files.imports = [ self.modules.homeManager.yazi ];

    yazi =
      {
        config,
        nyralib,
        shell,
        pkgs,
        ...
      }:

      let
        cfg = config.nyra.files.yazi;
      in
      {
        options.nyra.files.yazi = {
          enable = nyralib.mkDefaultDependentOption "Yazi" "nyra.files.default" "yazi";
        };

        config = lib.mkIf (cfg.enable) {
          programs.yazi = {
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
                    run = "xdg-open %s";
                    block = true;
                  }
                ];
              };
              input.cursor_blink = true;
            };
            plugins = with pkgs.yaziPlugins; {
              inherit full-border git lazygit;
            };
            initLua = ''
              require("full-border"):setup {
                type = ui.Border.ROUNDED,
              }
              require("git"):setup()
            '';
          };

          hyprnix.settings.bind =
            lib.mkIf (config.nyra.desktops.hyprland.enable && config.nyra.files.default == "yazi")
              {
                "SUPER + E".dispatcher.exec_cmd = "${config.nyra.terminals.default} -e yazi";
                "SUPER + ALT + E".dispatcher.exec_cmd =
                  "${config.nyra.terminals.default} --class floating-${config.nyra.terminals.default} -e yazi";
              };
        };
      };
  };
}
