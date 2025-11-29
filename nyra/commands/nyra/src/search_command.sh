query=${args[query]}
description=${args[--description]}

if [[ $description ]]; then
  nix search nixpkgs "$query" 2>/dev/null
else
  nix search nixpkgs "$query" --json 2>/dev/null | \
    jq -r --arg q "$query" 'to_entries[] | 
    select(.key | contains($q)) | 
    "* \(.key | split(".") | last) (\(.value.version // "unknown"))\n  \(.value.description // "No description")\n"
fi
