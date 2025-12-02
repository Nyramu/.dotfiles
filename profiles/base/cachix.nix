{ ... }:

{
  nix.settings.extra-substituters = [
    # Vicinae
    "https://vicinae.cachix.org"
    # Hyprland
    "https://hyprland.cachix.org"
  ];
  nix.settings.extra-trusted-public-keys = [
    # Vicinae
    "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
    # Hyprland
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
  ];
}
