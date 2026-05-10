{ self, ... }:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.dbus ];

    dbus = {
      services.dbus.enable = true;
      programs.dconf.enable = true;
    };
  };
}
