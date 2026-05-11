{ self, lib, ... }:
{
  flake.modules.homeManager = {
    miscellaneous.imports = [ self.modules.homeManager.packetTracer ];

    packetTracer =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.miscellaneous.packetTracer;
      in
      {
        options.nyra.miscellaneous.packetTracer = {
          enable = lib.mkEnableOption "packet tracer";
        };

        config = lib.mkIf (cfg.enable) {
          home.packages = with pkgs; [
            cisco-packet-tracer_9
          ];
        };
      };
  };
}
