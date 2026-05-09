{ self, ... }:
{
  flake.modules.homeManager = {
    core.imports = [ self.modules.homeManager.git ];

    git =
      {
        user,
        shell,
        pkgs,
        ...
      }:
      {
        programs.git = {
          enable = true;
          settings.user = {
            name = user.description;
            inherit (user) email;
          };
        };

        programs.jujutsu = {
          enable = true;
          settings = {
            user = {
              name = user.description;
              inherit (user) email;
            };
          };
        };

        programs.gh = {
          enable = true;
          extensions = [ pkgs.gh-dash ];
          settings = {
            git_protocol = "ssh";
            editor = "$EDITOR";
          };
        };

        programs.lazygit = {
          enable = true;
          enableBashIntegration = (shell == "bash");
          enableZshIntegration = (shell == "zsh");
          enableFishIntegration = (shell == "fish");
        };
      };
  };
}
