{ self, ... }:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.nix ];

    nix =
      { user, ... }:
      {
        nixpkgs.config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;
        };

        nix = {
          settings = {
            experimental-features = [
              "nix-command"
              "flakes"
              "pipe-operators"
            ];

            # Automatically detect files in the store that have identical contents, and replaces
            # them with hard links to a single copy. This saves disk space.
            auto-optimise-store = true;

            # Prevent garbage collection from altering nix shells managed by nix-direnv
            # https://github.com/nix-community/nix-direnv#installation
            keep-outputs = true;
            keep-derivations = true;

            # The maximum number of parallel TCP connections used to fetch files from binary caches and by other downloads.
            # It defaults to 25. 0 means no limit.
            http-connections = 64;

            # This option defines the maximum number of substitution jobs that Nix will try to run in
            # parallel. The default is 16. The minimum value one can choose is 1 and lower values will be
            # interpreted as 1.
            max-substitution-jobs = 64;
            max-jobs = "auto";

            # Whether to warn about dirty Git/Mercurial trees.
            warn-dirty = false;

            # The number of lines of the tail of the log to show if a build fails.
            log-lines = 25;

            # Make legacy nix commands use the XDG base directories instead of creating directories in $HOME.
            use-xdg-base-directories = true;

            # Allow the use of cachix
            trusted-users = [
              user.name
              "root"
              "@wheel"
            ];

            builders-use-substitutes = true;
          };
        };
      };
  };
}
