config=${args[config]}

nh os switch ~/.dotfiles -H ${config}

nh home switch ~/.dotfiles -c ${config}
