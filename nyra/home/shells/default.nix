{ config, pkgs, ... }:

let
  nyra-omp-theme = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/Nyramu/nyra-omp-theme/main/nyra-omp-theme.json";
    sha256 = "sha256-/V7MkBr47Ca6Vb+v4G26ZOTVGX+OiVDFWCKElzUUd7o=";
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
