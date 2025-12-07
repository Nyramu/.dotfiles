{
  description = "Nyramu's Personal Flake";

  outputs = { self, nixpkgs, home-manager, ... } @inputs: 
    let 
      systemSettings = {
        hostName = "nixos";
        dotfiles = "~/.dotfiles";
      };

      userSettings = {
        name = "Nyramu";
        email = "107689027+Nyramu@users.noreply.github.com";
      };

      inherit (nixpkgs) lib;

      createNixosProfile = name: system:
        lib.nixosSystem {
          inherit system;
          modules = [./profiles/${name}/configuration.nix];
          specialArgs = {
            inherit systemSettings userSettings inputs;
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
            inherit systemSettings userSettings inputs;
          };
        };
    in
  {
    nixosConfigurations = {
      main = createNixosProfile "main" "x86_64-linux";
      potato = createNixosProfile "potato" "x86_64-linux";
    };

    homeConfigurations = {
      main = createHomeProfile "main" "x86_64-linux"; 
      potato = createHomeProfile "potato" "x86_64-linux";
    };
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hyprland.url = "github:hyprwm/Hyprland";
    hyprnix = {
      url = "github:hyprland-community/hyprnix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprland.follows = "hyprland";
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

    eden = {
      url = "github:grantimatter/eden-flake";
      #inputs.nixpkgs.follows = "nixpkgs";
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
