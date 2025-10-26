{ pkgs, lib, ... }:

{
  programs.alacritty = {
    enable = true;
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
}
