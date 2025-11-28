{
  stdenv,
  installShellFiles,
  bashly,
  makeWrapper,
  nh,
  jmtpfs,
}:
stdenv.mkDerivation rec {
  name = "nyra";
  src = ./.;

  nativeBuildInputs = [
    installShellFiles
    bashly
    makeWrapper
  ];

  buildInputs = [nh jmtpfs];

  buildPhase = ''
    bashly add completions
    bashly generate
    bashly add completions_script
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp nyra $out/bin/${name}
    wrapProgram $out/bin/${name} \
      --prefix PATH : ${nh}/bin:${jmtpfs}/bin
  '';

  postInstall = ''
    installShellCompletion completions.bash
  '';
}
