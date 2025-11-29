{
  description = "Nyramu's Flake";

  outputs = { self, nixpkgs, home-manager, ... } @inputs: 
    let 
      systemSettings = {
        hostName = "nixos";

        dotfiles = "~/.dotfiles";

        kb = {
          layout = "it";
          variant = "";
        };
      };

      inherit (nixpkgs) lib;

      createNixosProfile = name: system:
        lib.nixosSystem {
          inherit system;
          modules = [./profiles/${name}/configuration.nix];
          specialArgs = {
            inherit systemSettings inputs;
          };
        };

      createHomeProfile = name: system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            overlays = [];
          };
          modules = [./profiles/${name}/home.nix];
          extraSpecialArgs = {
            inherit systemSettings inputs;
          };
        };
    in
  {
    nixosConfigurations = {
      main = createNixosProfile "main" "x86_64-linux";
    };

    homeConfigurations = {
      main = createHomeProfile "main" "x86_64-linux"; 
    };
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprnix = {
      url = "github:hyprland-community/hyprnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vicinae = {
      url = "github:vicinaehq/vicinae";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
