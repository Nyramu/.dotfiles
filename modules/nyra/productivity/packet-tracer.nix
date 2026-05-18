{ self, lib, ... }:
{
  flake.modules.homeManager = {
    productivity.imports = [ self.modules.homeManager.packetTracer ];

    packetTracer =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.productivity.packetTracer;
      in
      {
        options.nyra.productivity.packetTracer = {
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
