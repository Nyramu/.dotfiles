{ self, ... }:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.sddm ];

    sddm =
      { wayland, ... }:
      {
        services.displayManager.sddm = {
          enable = true;
          enableHidpi = true;
          autoNumlock = true;
          wayland.enable = wayland.enable;
        };
      };
  };
}
