{ pkgs, inputs, lib, config, ... }:

{
  imports = [ inputs.stylix.homeModules.stylix ]; 
  config.stylix = {
    targets = {
      hyprland.enable = lib.mkForce false;
      kitty.enable = lib.mkForce true;
      qutebrowser.enable = lib.mkForce true;
      librewolf.profileNames = [ "nyramu" ];
      zen-browser.profileNames = [ "nyramu" ];
    };
  };

  # Fix for Hyprnix
  options.wayland.windowManager.hyprland.settings = {
    decoration = lib.mkOption {default = {};};
    general = lib.mkOption {default = {};};
    group = lib.mkOption {default = {};};
    misc = lib.mkOption {default = {};};
  };
}
