{ self, ... }:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.networking ];

    networking =
      { user, host, ... }:
      {
        users.users.${user.name}.extraGroups = [ "networkmanager" ];
        networking = {
          hostName = host.name;
          networkmanager.enable = true;
        };
      };
  };
}
