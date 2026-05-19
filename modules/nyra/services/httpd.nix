{ self, lib, ... }:
{
  flake.modules.nixos = {
    services.imports = [ self.modules.nixos.httpd ];

    httpd =
      { config, user, ... }:

      let
        cfg = config.nyra.services.httpd;
        dir = "/home/${user.name}/localhost";
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
            extraModules = [ "rewrite" ];

            virtualHosts."localhost" = {
              documentRoot = dir;

              extraConfig = ''
                <Directory "${dir}">
                  AllowOverride All
                  Require all granted
                </Directory>

                DirectoryIndex index.php index.html
              '';
            };
          };

          systemd.tmpfiles.rules = [
            "z /home/${user.name} 0711 ${user.name} users -"
            "d ${dir} 0755 ${user.name} users -"
          ];

          networking.firewall.allowedTCPPorts = [ 80 ];
        };
      };
  };
}
