eval "packages=(${args[packages]:-})"

nix shell "${packages[@]/#/nixpkgs#}"
