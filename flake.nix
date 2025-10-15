{
  description = "Nyramu's Flake";

  outputs = { self, nixpkgs, home-manager, ... } @inputs:
    let 
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
  {
    nixosConfigurations = {
      system = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./profiles/main/configuration.nix ];
        specialArgs = { inherit inputs outputs; };
      };
    };

    homeConfigurations = {
      user = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
	modules = [ ./profiles/main/home.nix ];
        extraSpecialArgs = { inherit inputs outputs; };
      };
    };
  };

  inputs =
  {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprnix = {
      url = "github:hyprland-community/hyprnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
