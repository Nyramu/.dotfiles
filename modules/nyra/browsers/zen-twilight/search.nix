{ ... }:
{
  flake.modules.homeManager.zen-twilight = { user, ... }: {
    programs.zen-browser = {
      profiles.${user.name}.search = {
        force = true;
        engines = {

          brave = {
            name = "Brave Search";
            definedAliases = [ "brv" ];
            urls = [
              {
                template = "https://search.brave.com/search?q={searchTerms}";
              }
            ];
            icon = "https://brave.com/static-assets/images/brave-favicon.png";
          };

          nixpkgs = {
            name = "NixOS Packages";
            definedAliases = [ "pkgs" ];
            urls = [
              {
                template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
              }
            ];
            icon = "https://nixos.org/favicon.ico";
          };
          mynixos = {
            name = "MyNixOS";
            definedAliases = [ "mynix" ];
            urls = [
              {
                template = "https://mynixos.com/search?q={searchTerms}";
              }
            ];
            icon = "https://mynixos.com/favicon.ico";
          };

          github = {
            name = "GitHub";
            definedAliases = [ "gh" ];
            urls = [
              {
                template = "https://github.com/search?q={searchTerms}";
              }
            ];
            icon = "https://github.com/favicon.ico";
          };

          youtube = {
            name = "YouTube";
            definedAliases = [ "yt" ];
            urls = [
              {
                template = "https://www.youtube.com/results?search_query={searchTerms}";
              }
            ];
            icon = "https://www.youtube.com/favicon.ico";
          };
        };
      };
    };
  };
}
