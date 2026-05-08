{ self, ... }:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.graphics ];

    graphics = {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
    };
  };
}
