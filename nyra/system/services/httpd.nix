{
  config,
  lib,
  ...
}:
  
let
  nyraSettings = config.nyra.settings;
  cfg = config.nyra.system.httpd;
in
{
  options.nyra.system.httpd = {
    enable = lib.mkEnableOption "httpd";
  };

  config = lib.mkIf (cfg.enable) {
    services.httpd = {
      enable = true;
      enablePHP = true;
      adminAddr = "admin@localhost";
      user = "${nyraSettings.username}";
      group = "users";

      virtualHosts."localhost" = {
        documentRoot = "/home/${nyraSettings.username}/www";
        extraConfig = ''
          <Directory "/home/${nyraSettings.username}/www">;
            Options Indexes FollowSymLinks
            AllowOverride All
            Require all granted
          </Directory>
        '';
      };
    };

    networking.firewall.allowedTCPPorts = [ 80 ];
  };
}
