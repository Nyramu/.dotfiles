{ self, ... }:
{
  flake.modules.homeManager = {
    core.imports = [ self.modules.homeManager.ohMyPosh ];

    ohMyPosh =
      { shell, pkgs, ... }:

      let
        nyra-omp-theme = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/Nyramu/nyra-omp-theme/main/nyra-omp-theme.json";
          sha256 = "sha256-o+hVW2q6J3TVbImtC/bmbIhempUCvfqpXst5peDMu8o=";
        };
      in
      {
        programs.oh-my-posh = {
          enable = true;
          enableBashIntegration = (shell == "bash");
          enableZshIntegration = (shell == "zsh");
          enableFishIntegration = (shell == "fish");
          settings = builtins.fromJSON (builtins.readFile nyra-omp-theme);
        };
      };
  };
}
