{ lib, ... }:

{
  options.nyra.desktops = {
    hyprland = {
      enable = lib.mkEnableOption "hyprland";
      monitors = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "list of hyprland monitors";
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
    };
  };
}
