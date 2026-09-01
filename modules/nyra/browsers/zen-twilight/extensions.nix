{ inputs, ... }:
{
  flake.modules.homeManager.zen-twilight =
    { user, pkgs, ... }:

    let
      # Fix for unfree packages not being installed despite being allowed
      firefox-addons = pkgs.callPackage inputs.firefox-addons {
        inherit (pkgs) fetchurl stdenv lib;
        buildMozillaXpiAddon =
          (import "${inputs.firefox-addons}/../../lib/mozilla.nix" { lib = pkgs.lib; }).mkBuildMozillaXpiAddon
            { inherit (pkgs) fetchurl stdenv; };
      };
    in
    {
      programs.zen-browser = {
        profiles.${user.name}.extensions.packages = with firefox-addons; [
          ublock-origin
          dearrow
          return-youtube-dislikes
          augmented-steam
          absolute-enable-right-click
          auto-reject-cookies
          #animalese-typing # Cool and cute but annoying
          betterttv
          censor-tracker
          clearurls
          disconnect
          material-icons-for-github
          image-search-options
          indie-wiki-buddy
          to-google-translate
          terms-of-service-didnt-read
          tampermonkey
          one-click-wayback
          qr-code-address-bar
          youtube-no-translation
          youtube-shorts-block
          youtube-nonstop
          darkreader
        ];
      };
    };
}
