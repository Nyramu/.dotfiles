{ config, pkgs, ... }:

let
  nyra-omp-theme = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/Nyramu/nyra-omp-theme/main/nyra-omp-theme.json";
    sha256 = "sha256-o+hVW2q6J3TVbImtC/bmbIhempUCvfqpXst5peDMu8o=";
  };
in
{
  imports = [
    ./zsh.nix
    ./nushell.nix
    ./commands
  ];

  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = config.nyra.shells.zsh.enable;
    enableNushellIntegration = config.nyra.shells.nushell.enable;
    settings = builtins.fromJSON (builtins.readFile nyra-omp-theme);
  };
}
