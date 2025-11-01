{ config, lib, pkgs, ... }: with lib;

let 
  cfg = config.nyra.system.login;
in 
{
  options.nyra.system.login = {
    userIcon = mkOption {
      type = types.enum [ "burrito-ascii" ];
      default = "burrito-ascii";
      description = "Icon file for the user";
    };
  };

  config = {
    # Set user face (avatar)
    systemd.tmpfiles.rules = let
      user = "nyramu";
      iconPath = ../../../resources/${cfg.userIcon}.png;
    in [
      "f+ /var/lib/AccountsService/users/${user}  0600 root root -  [User]\\nIcon=/var/lib/AccountsService/icons/${user}\\n"
      "L+ /var/lib/AccountsService/icons/${user}  -    -    -    -  ${iconPath}"
    ];
  };
}
