{
  description = "Nyramu's Flake";

  outputs = { self, nixpkgs, ... } @inputs:
    let 
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      lib = nixpkgs.lib;
    in
  {
    nixosConfigurations = {
      main = lib.nixosSystem {
        inherit system;
        modules = [ ./profiles/main/configuration.nix ];
        specialArgs = { inherit inputs outputs; };
      };
    };
  };

  inputs =
  {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
}
