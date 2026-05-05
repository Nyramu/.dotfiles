{
  config,
  lib,
  ...
}:

let
  nyraSettings = config.nyra.settings;
  cfg = config.nyra.services.httpd;
in
{
  options.nyra.services.httpd = {
    enable = lib.mkEnableOption "httpd";
  };

  config = lib.mkIf (cfg.enable) {
    services.httpd = {
      enable = true;
      enablePHP = true;
      adminAddr = "admin@localhost";
      user = "${nyraSettings.username}";
      group = "users";
      extraModules = [ "rewrite" ];

      virtualHosts."localhost" = {
        documentRoot = "/home/${nyraSettings.username}/localhost";
        extraConfig = ''
          <Directory "/home/${nyraSettings.username}/localhost">;
            Options Indexes FollowSymLinks
            AllowOverride All
            Require all granted
          </Directory>
          DirectoryIndex index.php index.html
        '';
      };
    };

    networking.firewall.allowedTCPPorts = [ 80 ];
  };
}
