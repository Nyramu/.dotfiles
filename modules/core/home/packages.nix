{ self, config, ... }:
{
  flake.modules.homeManager = {
    core.imports = [ self.modules.homeManager.packages ];

    packages =
      { host, ... }:

      let
        flakePkgs = config.flake.packages.${host.system};
      in
      {
        home.packages = with flakePkgs; [
          nyra
          screen-shot
          screen-record
        ];
      };
  };
}
