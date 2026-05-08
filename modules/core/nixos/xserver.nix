{ self, ... }:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.xserver ];

    xserver = {
      services.xserver = {
        enable = true; # Enable the X11 windowing system
      };
    };
  };
}
