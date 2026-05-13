{ self, ... }:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.ssh ];

    ssh = {
      services.openssh.enable = true;
    };
  };
}
