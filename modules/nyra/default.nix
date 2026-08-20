{ self, ... }: {

  flake.modules.homeManager.nyra = {
    imports = with self.modules.homeManager; [
      browsers
      desktops
      editors
      files
      gaming
      layers
      miscellaneous
      music
      productivity
      services
      shells
      socials
      terminals
    ];
  };

  flake.modules.nixos.nyra = {
    imports = with self.modules.nixos; [
      desktops
      gaming
      layers
      login
      miscellaneous
      services
    ];
  };
}
