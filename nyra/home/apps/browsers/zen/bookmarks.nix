{ config, ... }:

{
  programs.zen-browser = {
    profiles.${config.nyra.settings.username}.bookmarks = {
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
              name = "Hyprnix";
              url = "https://github.com/Nyramu/hyprnix";
            }
          ];
        }
      ];
    };
  };
}
