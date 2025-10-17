{ pkgs, inputs, ... }:

{
  imports = [
    inputs.hyprnix.homeManagerModules.hyprland
    ./config.nix
    ./binds.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    reloadConfig = true;
    systemd.enable = true;
    recommendedEnvironment = true;

    xwayland.enable = true;

    portal = {
      enable = true;
    };

    settings = {
      monitor = [ ", highres, auto, 1" ];
      input = {
        kb_layout = "it";
      };
    };

    #config.exec_once = [
      # Allow apps with risen perms after agent to connect to local xwayland
      #"${lib.getExe pkgs.xorg.xhost} +local:"
    #];
  };
}
