{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.theming ];

    theming =
      {
        theme,
        performance,
        pkgs,
        ...
      }:
      {
        imports = [
          inputs.stylix.nixosModules.stylix
        ]
        ++ lib.optionals (theme != null) [ self.modules.nixos."theme-${theme}" ];

        config = {
          stylix = {
            enable = lib.mkDefault true;
            autoEnable = lib.mkDefault true;

            base16Scheme = lib.mkDefault {
              base00 = "#262626";
              base01 = "#3a3a3a";
              base02 = "#4e4e4e";
              base03 = "#8a8a8a";
              base04 = "#949494";
              base05 = "#dab997";
              base06 = "#d5c4a1";
              base07 = "#ebdbb2";
              base08 = "#d75f5f";
              base09 = "#ff8700";
              base0A = "#ffaf00";
              base0B = "#afaf00";
              base0C = "#85ad85";
              base0D = "#83adad";
              base0E = "#d485ad";
              base0F = "#d65d0e";
            };

            image = lib.mkDefault pkgs.nixos-artwork.wallpapers.gear.gnomeFilePath;

            polarity = lib.mkDefault "dark";

            opacity =
              if (performance == "potato") then
                {
                  terminal = lib.mkForce 1.0;
                  applications = lib.mkForce 1.0;
                  desktop = lib.mkForce 1.0;
                  popups = lib.mkForce 1.0;
                }
              else
                {
                  terminal = lib.mkDefault 0.63;
                  applications = lib.mkDefault 0.6;
                  desktop = lib.mkDefault 0.7;
                  popups = lib.mkDefault 0.7;
                };

            fonts = {
              serif = {
                package = lib.mkDefault pkgs.nerd-fonts.jetbrains-mono;
                name = lib.mkDefault "JetBrainsMono Nerd Font";
              };
              sansSerif = {
                package = lib.mkDefault pkgs.nerd-fonts.jetbrains-mono;
                name = lib.mkDefault "JetBrainsMono Nerd Font";
              };
              monospace = {
                package = lib.mkDefault pkgs.nerd-fonts.jetbrains-mono;
                name = lib.mkDefault "JetBrainsMono Nerd Font Mono";
              };
              emoji = {
                package = lib.mkDefault pkgs.nerd-fonts.symbols-only;
                name = lib.mkDefault "Symbols Nerd Font";
              };
              sizes = {
                applications = lib.mkDefault 12;
                desktop = lib.mkDefault 10;
                popups = lib.mkDefault 10;
                terminal = lib.mkDefault 12;
              };
            };

            icons = {
              enable = lib.mkDefault true;
              package = lib.mkDefault pkgs.gruvbox-plus-icons;
              dark = lib.mkDefault "gruvbox-plus";
              light = lib.mkDefault "gruvbox-plus";
            };

            targets.qt.enable = lib.mkDefault false;
            targets.gtksourceview.enable = lib.mkDefault false;
          };
        };
      };
  };
}
