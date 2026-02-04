{ lib, ... }:

{
  options.nyra.desktops = {
    hyprland = {
      enable = lib.mkEnableOption "hyprland";
      monitors = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "list of hyprland monitors";
      };
    };
  };
}
