{ self, lib, ... }:
{
  flake.modules.homeManager = {
    terminals.imports = [ self.modules.homeManager.alacritty ];

    alacritty =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.terminals.alacritty;
        default = config.nyra.terminals.default;
      in
      {
        options.nyra.terminals.alacritty = {
          enable = lib.mkEnableOption "alacritty";
        };

        config = {
          programs.alacritty = lib.mkIf (cfg.enable) {
            enable = true;
            package = pkgs.alacritty-graphics;
            settings = {
              general = {
                working_directory = "~/.dotfiles";
                live_config_reload = true;
              };
              window = {
                decorations = "None";
                decorations_theme_variant = "None";
                blur = false;
              };
              mouse = {
                hide_when_typing = true;
                bindings = [
                  {
                    mouse = "Right";
                    mods = "Control";
                    action = "Paste";
                  }
                ];
              };
              selection.save_to_clipboard = true;
            };
          };
          nyra.terminals.alacritty.enable = lib.mkDefault (default == "alacritty");
        };
      };
  };
}
