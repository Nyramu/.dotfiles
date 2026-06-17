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

        # Run schedulers from userspace
        services.scx = {
          enable = true;
          # scx_lavd: Optimized for gaming, works well for general use cases
          scheduler = lib.mkDefault "scx_lavd";
          extraArgs = lib.mkDefault [ "--performance" ];
        };

        # Set the maximum amount of virtual memory areas a single process can map. It's set like on Steam Deck
        boot.kernel.sysctl."vm.max_map_count" = lib.mkForce 2147483642;
      };
  };
}
