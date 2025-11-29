packages=${args[packages]}

nix shell nixpkgs#${packages// / nixpkgs#}
