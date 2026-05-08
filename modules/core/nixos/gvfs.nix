{ self, ... }:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.gvfs ];

    gvfs = {
      services.gvfs = {
        enable = true;
      };
    };
  };
}
