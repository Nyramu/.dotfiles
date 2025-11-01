{ config, lib, pkgs, ... }: with lib;

let 
  cfg = config.nyra.system.login;
in 
{
  options.nyra.system.login = {
    userIcon = mkOption {
      type = types.path;
      description = "Path to icon file for the user";
    };
  };

  config = {
    # Set user face (avatar)
    systemd.tmpfiles.rules = let
      user = "nyramu";
      iconPath = cfg.userIcon;
    in [
      "f+ /var/lib/AccountsService/users/${user}  0600 root root -  [User]\\nIcon=/var/lib/AccountsService/icons/${user}\\n"
      "L+ /var/lib/AccountsService/icons/${user}  -    -    -    -  ${iconPath}"
    ];
  };
}
