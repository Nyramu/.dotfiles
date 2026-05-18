{ self, ... }:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.user ];

    user =
      {
        user,
        shell,
        pkgs,
        ...
      }:
      {
        users = {
          users.${user.name} = {
            isNormalUser = true;
            description = "${user.description}";
            extraGroups = [
              "wheel"
            ];
          };

          defaultUserShell = pkgs.${shell};
        };

        programs.${shell}.enable = true;
      };
  };
}
