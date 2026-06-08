{ self, ... }:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.packages ];

    packages =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          git
          zip
          unzip
          nixfmt
          curl
          util-linux
          zoxide
          usbutils
        ];
      };
  };
}
