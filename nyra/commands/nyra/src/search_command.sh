query=${args[query]}

nix search nixpkgs "$query" --json | jq -r 'to_entries[] | "\(.key)\n  \(.value.description // "No description")\n"'
