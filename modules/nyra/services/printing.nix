{ self, lib, ... }:
{
  flake.modules.nixos = {
    services.imports = [ self.modules.nixos.printing ];

    printing =
      { config, ... }:

      let
        cfg = config.nyra.services.printing;
      in
      {
        options.nyra.services.printing = {
          enable = lib.mkEnableOption "printing services";
        };

        config = lib.mkIf (cfg.enable) {
          services.printing = {
            enable = true;
            browsing = true;
            listenAddresses = [ "*:631" ];
            allowFrom = [ "all" ];
            defaultShared = true;
          };

          networking.firewall = {
            allowedUDPPorts = [ 631 ];
            allowedTCPPorts = [ 631 ];
          };
        };
      };
  };
}
