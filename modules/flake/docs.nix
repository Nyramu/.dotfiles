{
  self,
  lib,
  inputs,
  ...
}:
{
  perSystem =
    { pkgs, system, ... }:
    let
      repoUrl = "https://github.com/Nyramu/.dotfiles/blob/main";

      filterNyra = options: lib.filterAttrs (name: _: lib.hasPrefix "nyra" name) options;

      mkTransform =
        opt:
        opt
        // {
          declarations = map (
            decl:
            let
              declStr = toString decl;
              path = builtins.head (lib.splitString "," declStr);
              rel = "modules/" + lib.last (lib.splitString "modules/" path);
            in
            {
              name = rel;
              url = "${repoUrl}/${rel}";
            }
          ) opt.declarations;
        };

      nixosOptions = pkgs.nixosOptionsDoc {
        options = filterNyra self.nixosConfigurations.main.options;
        warningsAreErrors = false;
        transformOptions = mkTransform;
      };
      hmOptions = pkgs.nixosOptionsDoc {
        options = filterNyra self.homeConfigurations.main.options;
        warningsAreErrors = false;
        transformOptions = mkTransform;
      };

      ndg = inputs.ndg.packages.${system}.ndg;

      mkHtmlDocs =
        name: optionsDoc:
        pkgs.runCommandLocal "dotfiles-docs-${name}"
          {
            nativeBuildInputs = [ ndg ];
          }
          ''
            mkdir -p $out
            ndg html \
              --module-options ${optionsDoc.optionsJSON}/share/doc/nixos/options.json \
              --output-dir $out \
              --title "Nyra ${name}"
          '';
    in
    {
      packages = {
        docs-nixos = mkHtmlDocs "NixOS" nixosOptions;
        docs-hm = mkHtmlDocs "Home Manager" hmOptions;
        inherit ndg;
      };
    };
}
