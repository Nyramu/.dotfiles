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

    systemd.enable = true;
    xwayland.enable = true;
    reloadConfig = true;
    recommendedEnvironment = true;

    portal.enable = false;

    config.monitor = [
      "eDP-1, 1920x1200@60, auto, 1"
      ", preferred, auto, 1"
    ]; 

    config.input = {
        kb_layout = "it";
    };

    config.exec_once = [
      # Allow apps with risen perms after agent to connect to local xwayland
      #"${lib.getExe pkgs.xorg.xhost} +local:"
    ];
  };
}
