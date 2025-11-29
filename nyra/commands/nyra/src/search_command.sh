query=${args[query]}
classic=${args[--classic]}

if [[ $classic ]]; then
  nix search nixpkgs "$query" 2>/dev/null
else
  jq_filter='to_entries[] | select(.key | contains($q)) | "* \(.key | sub("^.*\\.(x86_64-linux|aarch64-linux|x86_64-darwin|aarch64-darwin)\\."; "")) (\(.value.version // "unknown"))\n  \(.value.description // "No description")\n"'
  
  nix search nixpkgs "$query" --json 2>/dev/null | \
    jq -r --arg q "$query" "$jq_filter" | \
    grep --color=always -iE "$query|$"
fi
