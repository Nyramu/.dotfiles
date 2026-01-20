{ lib, inputs, ... }: with lib;

{
  imports = [ inputs.stylix.homeModules.stylix ]; 
  config.stylix = {
    targets = {
      kitty.enable = mkForce true;
      qutebrowser.enable = mkForce true;
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
