{ inputs, pkgs, ... }:

let
  # Fix for unfree packages not being installed despite being allowed
  firefox-addons = pkgs.callPackage inputs.firefox-addons {
    inherit (pkgs) fetchurl stdenv lib;
  };
in
{
  programs.zen-browser = {
    profiles.nyramu.extensions.packages = with firefox-addons; [
      ublock-origin
      dearrow
      return-youtube-dislikes
      augmented-steam
      protondb-for-steam
      #animalese-typing # Cool and cute but annoying
      betterttv
      censor-tracker
      clearurls
      copy-selection-as-markdown
      #firenvim
      image-search-options
      indie-wiki-buddy
      simplifygmail
      the-camelizer-price-history-ch
      to-google-translate
      tampermonkey
      youtube-no-translation
      youtube-shorts-block
      youtube-nonstop
      darkreader
    ];
  };
}
