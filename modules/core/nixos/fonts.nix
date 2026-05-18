{ self, ... }:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.fonts ];

    fonts =
      { pkgs, ... }:
      {
        # "fc-cache -fv" to manually refresh cache
        # "fc-list : family | sort | uniq" to list
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
