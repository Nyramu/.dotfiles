{ self, ... }:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.printing ];

    printing = {
      services.printing = {
        enable = true;
      };
    };
  };
}
