{
  self,
  lib,
  inputs,
  ...
}:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.kernel ];

    kernel =
      { pkgs, ... }:
      {
        # Use CachyOS latest LTO kernel
        nixpkgs.overlays = [ inputs.cachyos-kernel.overlays.pinned ];
        boot.kernelPackages = lib.mkDefault pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto;

        # Set the maximum amount of virtual memory areas a single process can map. It's set like on Steam Deck
        boot.kernel.sysctl."vm.max_map_count" = lib.mkForce 2147483642;

        # CachyOS Kernel Cache
        nix.settings = rec {
          substituters = [ "https://attic.xuyh0120.win/lantian" ];
          trusted-substituters = substituters;
          trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];
        };
      };
  };
}
