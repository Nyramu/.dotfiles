{ self, ... }:
{
  flake.modules.homeManager = {
    core.imports = [ self.modules.homeManager.nix ];

    nix = {
      nixpkgs.config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };
  };
}
