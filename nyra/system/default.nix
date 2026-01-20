{ inputs, ... }:

{
  imports = [
    inputs.stylix.nixosModules.stylix
    ./apps
    ./hardware
    ./desktops
    ./fonts
    ./login
    ./security
    ../common
  ];
}
