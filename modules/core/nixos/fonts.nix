{ self, ... }:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.fonts ];

    fonts =
      { pkgs, ... }:
      {
        fonts = {
          packages = with pkgs; [
            nerd-fonts.dejavu-sans-mono
            nerd-fonts.jetbrains-mono
          ];

          fontconfig = {
            antialias = true;
            hinting = {
              style = "full";
            };
          };
        };
      };
  };
}
