{ ... }:
{
  flake.modules.homeManager.zen-twilight =
    { user, ... }:
    {
      programs.zen-browser = {
        profiles.${user.name}.bookmarks = {
          force = true;
          settings = [
            {
              name = "Miscellaneous";
              toolbar = true;
              bookmarks = [
                {
                  name = "Linux Hub";
                  tags = [
                    "xda"
                    "linux"
                  ];
                  url = "https://www.xda-developers.com/linux-hub/";
                }
              ];
            }
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
              name = "Git";
              toolbar = true;
              bookmarks = [
                {
                  name = "My stars";
                  url = "https://github.com/Nyramu?tab=stars";
                }
                {
                  name = "My dotfiles";
                  url = "https://codeberg.org/Nyramu/.dotfiles";
                }
                {
                  name = "Hyprnix";
                  url = "https://codeberg.org/Nyramu/hyprnix";
                }
              ];
            }
          ];
        };
      };
    };
}
