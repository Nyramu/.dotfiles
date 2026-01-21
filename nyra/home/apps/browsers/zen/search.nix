{ ... }:

{
  programs.zen-browser = {
    policies = {
      SearchEngines = {
        Add = [
          {
            Name = "DuckDuckGo";
            URLTemplate = "https://duckduckgo.com/?q={searchTerms}";
            Method = "GET";
            IconURL = "https://duckduckgo.com/favicon.ico";
            Alias = "ddg";
            Description = "DuckDuckGo Search";
            SuggestURLTemplate = "https://duckduckgo.com/ac/?q={searchTerms}&type=list";
          }
          {
            Name = "Brave Search";
            URLTemplate = "https://search.brave.com/search?q={searchTerms}";
            Method = "GET";
            IconURL = "https://brave.com/static-assets/images/brave-favicon.png";
            Alias = "brave";
            Description = "Brave Search";
          }
          {
            Name = "GitHub";
            URLTemplate = "https://github.com/search?q={searchTerms}";
            Method = "GET";
            IconURL = "https://github.com/favicon.ico";
            Alias = "gh";
            Description = "Search GitHub repositories";
          }
          {
            Name = "YouTube";
            URLTemplate = "https://www.youtube.com/results?search_query={searchTerms}";
            Method = "GET";
            IconURL = "https://www.youtube.com/favicon.ico";
            Alias = "yt";
            Description = "Search YouTube videos";
            SuggestURLTemplate = "https://suggestqueries.google.com/complete/search?client=youtube&ds=yt&q={searchTerms}";
          }
          {
            Name = "NixOS Packages";
            URLTemplate = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
            Method = "GET";
            IconURL = "https://nixos.org/favicon.ico";
            Alias = "nixpkgs";
            Description = "Search NixOS packages (unstable)";
          }
          {
            Name = "MyNixOS";
            URLTemplate = "https://mynixos.com/search?q={searchTerms}";
            Method = "GET";
            IconURL = "https://mynixos.com/favicon.ico";
            Alias = "mynix";
            Description = "Search NixOS options and packages";
          }
        ];
        Remove = [
          "Bing"
          "Ecosia"
          "Google"
          "Perplexity"
          "Qwant"
          "Wikipedia (en)"
        ];
        Default = "DuckDuckGo";
        PreventInstalls = true;
      };
    };
  };
}
