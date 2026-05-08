{ self, ... }:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.rtkit ];

    rtkit = {
      security.rtkit = {
        enable = true;
      };
    };
  };
}
