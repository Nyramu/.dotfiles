{ userSettings, ... }:

{
  programs.zen-browser = {
    profiles.${userSettings.username}.bookmarks = {
      force = true;
      settings = [
        {
          name = "NixOS";
          toolbar = true;
          bookmarks = [
            {
              name = "Wiki";
              tags = [
                "wiki"
                "nix"
              ];
              url = "https://wiki.nixos.org/";
            }
          ];
        }
        {
          name = "GitHub";
          toolbar = true;
          bookmarks = [
            {
              name = "My stars";
              url = "https://github.com/Nyramu?tab=stars";
            }
            {
              name = "My dotfiles";
              url = "https://github.com/Nyramu/.dotfiles";
            }
            {
              name = "Gab's dotfiles";
              url = "https://github.com/gabrielemercolino/.dotfiles";
            }
          ];
        }
        {
          name = "Configs for my dotfiles";
          toolbar = false;
          bookmarks = [
            {
              name = "Noctalia";
              url = "https://docs.noctalia.dev/getting-started/nixos/";
            }
          ];
        }
      ];
    };
  };
}
