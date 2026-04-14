{ config, lib, ... }:

let
  cfg = config.nyra.desktops.hyprland;
in
{
  options.nyra.desktops.hyprland = {
    enable = lib.mkEnableOption "hyprland";

    monitors = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      default = [ ];
      description = "list of hyprland monitors";
    };

    shader = {
      enable = lib.mkEnableOption "enable screen shader";
      name = lib.mkOption {
        type = lib.types.enum [
          "vibrant"
          "less-saturation"
        ];
        default = "vibrant";
        description = "Choose a screen shader: vibrant, less-saturation";
      };
      path = lib.mkOption {
        type = lib.types.path;
        description = "Path to chosen screen shader";
      };
    };

    dynamic-cursors = {
      enable = lib.mkEnableOption "hyprland dynamic-cursors plugin";
      mode = lib.mkOption {
        type = lib.types.enum [
          "rotate"
          "shake"
        ];
        default = "rotate";
      };
    };

    hyprexpo = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "hyprland hyprexpo plugin";
      };
    };

    hyprfocus = {
      enable = lib.mkEnableOption "hyprland hyprfocus plugin";
    };

    xtra-dispatchers = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "hyprland xtra-dispatchers plugin";
      };
    };
  };

  config.nyra.desktops.hyprland = {
    shader = {
      path = ../../../resources/shaders/hyprland/${cfg.shader.name}.frag;
    };
  };
}
