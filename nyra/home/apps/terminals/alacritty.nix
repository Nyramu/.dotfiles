{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.home.apps.terminals;
in
{
  options.nyra.home.apps.terminals.alacritty = {
    enable = mkOption {
      type = types.bool;
      default = cfg.default == "alacritty";
    };
  };

  config = {
    programs.alacritty = {
      enable = cfg.alacritty.enable;
      settings = {
        general = {
          working_directory = "/home/nyramu/.dotfiles";
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
            { mouse = "Right"; mods = "Control"; action = "Paste"; }
          ];
        };
        selection.save_to_clipboard = true;
      };
    };   
  };
}
