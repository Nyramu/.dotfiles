{ ... }:

{
  imports = [
    ./zsh.nix
    ./nushell.nix
    ./commands
  ];

  programs.oh-my-posh = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    settings = {
      
    };
  };
}
