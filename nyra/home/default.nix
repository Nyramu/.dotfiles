{ lib, inputs, ... }:
with lib;

{
  imports = [
    inputs.stylix.homeModules.stylix
    ./apps
    ./services
    ./shells
    ./desktops
    ../common
  ];

  stylix = {
    targets = {
      kitty.enable = mkForce true;
      qutebrowser.enable = mkForce true;
      zen-browser.profileNames = [ "nyramu" ];
    };
  };
}
