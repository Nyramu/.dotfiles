{
  perSystem =
    { pkgs, ... }:
    {
      packages.nyra = pkgs.stdenv.mkDerivation rec {
        name = "nyra";
        src = ./.;

        nativeBuildInputs = with pkgs; [
          installShellFiles
          bashly
          makeWrapper
        ];

        buildPhase = ''
          bashly add completions
          bashly generate
          bashly add completions_script
        '';

        installPhase = with pkgs; ''
          mkdir -p $out/bin
          mkdir -p $out/share

          cp nyra $out/bin/${name}

          wrapProgram $out/bin/${name} \
            --prefix PATH : ${nh}/bin:${android-file-transfer}/bin:${jq}/bin
        '';

        postInstall = ''
          installShellCompletion completions.bash
        '';
      };
    };
}
