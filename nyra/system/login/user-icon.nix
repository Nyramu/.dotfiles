{ config, lib, pkgs, ... }: with lib;

let 
  cfg = config.nyra.system.login;
in 
{
  options.nyra.system.login = {
    type = lib.types.attrsOf (lib.types.submodule ({ userName, ... }: {
      options = {
        icon = lib.mkOption {
          type = lib.types.path;
          description = "Path to icon file for user ${userName}";
        };
      };
    }));
    default = {};
    description = "Per-user icon setting";
  }

  config = {
    assertions = lib.mapAttrsToList (name: value: {
      assertion = name != "";
      message = "Username cannot be empty in settings";
    }) cfg;

    # Set user face (avatar)
    systemd.tmpfiles.rules = let
      user = cfg.userName;
      iconPath = cfg.userName.icon;
    in [
      "f+ /var/lib/AccountsService/users/${user}  0600 root root -  [User]\\nIcon=/var/lib/AccountsService/icons/${user}\\n"
      "L+ /var/lib/AccountsService/icons/${user}  -    -    -    -  ${iconPath}"
    ];
  };
}