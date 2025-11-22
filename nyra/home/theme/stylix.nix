{ lib, inputs, ... }: with lib;

{
  imports = [ inputs.stylix.homeModules.stylix ]; 
  config.stylix = {
    targets = {
      hyprland.enable = mkForce false;
      waybar.enable = mkForce false;
      rofi.enable = mkForce true;
      kitty.enable = mkForce true;
      qutebrowser.enable = mkForce true;
      librewolf.profileNames = [ "nyramu" ];
      zen-browser.profileNames = [ "nyramu" ];
    };
  };

  # Fix for Hyprnix
  options.wayland.windowManager.hyprland.settings = {
    decoration = mkOption {default = {};};
    general = mkOption {default = {};};
    group = mkOption {default = {};};
    misc = mkOption {default = {};};
  };
}
