{ self, ... }:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.libinput ];

    libinput = {
      services.libinput = {
        enable = true;
      };
    };
  };
}
