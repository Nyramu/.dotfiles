{ pkgs, inputs, lib, config, ... }:


let 
  theme = import ../aesthetics/themes/sunset.nix { inherit pkgs; };
in
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  config.stylix = {
    enable = true;
    autoEnable = true;

    # Type "fc-list : family | sort | uniq" in the terminal to see every font
    base16Scheme = theme.palette;
    fonts = theme.fonts; 
    image = theme.background;
    polarity = theme.polarity;

    opacity = {
      terminal = 0.6;
      applications = 0.7;
      # I can apply it for desktop and popups
    };
  };
}
