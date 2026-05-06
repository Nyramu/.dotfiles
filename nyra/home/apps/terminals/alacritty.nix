{ config, lib, ... }:

let
  cfg = config.nyra.apps.terminals;
in
{
  options.nyra.apps.terminals.alacritty = {
    enable = lib.mkEnableOption "alacritty";
  };

  config = {
    nyra.apps.terminals.alacritty.enable = lib.mkDefault (cfg.default == "alacritty");
    programs.alacritty = {
      enable = cfg.alacritty.enable;
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
  };
}
