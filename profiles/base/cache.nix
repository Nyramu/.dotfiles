{ ... }:

{
  nix.settings = rec {
    substituters = [
      # Vicinae
      "https://vicinae.cachix.org"
      # Hyprland
      "https://hyprland.cachix.org"
      # Eden Emulator
      "https://eden-emu-flake.cachix.org"
      # CachyOS Kernels
      "https://attic.xuyh0120.win/lantian"
    ];
    trusted-substituters = substituters;
    trusted-public-keys = [
      # Vicinae
      "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
      # Hyprland
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      # Eden Emulator
      "eden-emu-flake.cachix.org-1:qMKfHpBsRhMpxrc4FawVy+IeYAvFhhv94qiB69Bl0RU="
      # CachyOS Kernels
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    ];
  };
}
