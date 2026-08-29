{ lib, ... }:
{
  flake.lib.nyralib = { config, ... }: {
    mkEnabledOption = desc: lib.mkEnableOption desc // { default = true; };

    mkDependentOption =
      desc: dep:
      lib.mkEnableOption desc
      // {
        default =
          lib.attrByPath (lib.splitString "." dep) (throw "nyralib: option '${dep}' does not exist.")
            config;
        defaultText = lib.literalExpression dep;
      };

    mkDependentOptionFrom =
      desc: deps:
      lib.mkEnableOption desc
      // {
        default = builtins.all (
          dep:
          lib.attrByPath (lib.splitString "." dep) (throw "nyralib: option '${dep}' does not exist.") config
        ) deps;
        defaultText = lib.literalExpression (lib.concatStringsSep " && " deps);
      };

    mkDependentOptionFromAny =
      desc: deps:
      lib.mkEnableOption desc
      // {
        default = builtins.any (
          dep:
          lib.attrByPath (lib.splitString "." dep) (throw "nyralib: option '${dep}' does not exist.") config
        ) deps;
        defaultText = lib.literalExpression (lib.concatStringsSep " || " deps);
      };

    mkDefaultOption =
      desc: dir:
      lib.mkOption {
        type = lib.types.nullOr (
          lib.types.enum (
            builtins.readDir dir
            |> builtins.attrNames
            |> builtins.filter (n: n != "default.nix")
            |> map (n: lib.removeSuffix ".nix" n)
          )
        );
        default = null;
        description = "Set a default ${desc}";
      };

    mkDefaultDependentOption =
      desc: dep: val:
      lib.mkEnableOption desc
      // {
        default =
          (lib.attrByPath (lib.splitString "." dep) (throw "nyralib: option '${dep}' does not exist.") config)
          == val;
        defaultText = lib.literalExpression "${dep} == ${lib.escapeNixString val}";
      };
  };
}
