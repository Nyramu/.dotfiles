{
  self,
  user,
  lib,
  ...
}:
{
  flake.modules.homeManager = {
    terminals.imports = [ self.modules.homeManager.alacritty ];

    alacritty =
      {
        config,
        nyralib,
        pkgs,
        ...
      }:

      let
        cfg = config.nyra.terminals.alacritty;
      in
      {
        options.nyra.terminals.alacritty = {
          enable = nyralib.mkDefaultDependentOption "Alacritty" "nyra.terminals.default" "alacritty";
        };

        config = lib.mkIf (cfg.enable) {
          programs.alacritty = {
            enable = true;
            package = pkgs.alacritty-graphics;
            settings = {
              general = {
                working_directory = user.dotfiles;
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
        };
      };
  };
}
