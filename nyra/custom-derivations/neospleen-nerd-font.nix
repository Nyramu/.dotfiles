{ lib, stdenvNoCC, nerd-font-patcher }:
  
stdenvNoCC.mkDerivation rec {
  pname = "neospleen-nerd-font";
  version = "1.0.62";

  src = builtins.fetchurl {
    url = "https://github.com/mbwilding/NeoSpleen/releases/download/${version}/NeoSpleen-Regular.ttf";
    sha256 = "sha256:1ar71p1jqpgy3z0i1wzckicj64s7ilza70bmm0sgawlqgb55fhsc";
  };

  nativeBuildInputs = [nerd-font-patcher];

  dontUnpack = true;

  buildPhase = ''
    runHook preBuild

    mkdir -p mono proportional

    # Mono
    cp $src mono/NeoSpleen-Regular.ttf
    chmod +w mono/NeoSpleen-Regular.ttf
    cd mono
    nerd-font-patcher NeoSpleen-Regular.ttf \
      --complete \
      --careful \
      --mono \
      --outputdir .
    cd ..

    # Proportional
    cp $src proportional/NeoSpleen-Regular.ttf
    chmod +w proportional/NeoSpleen-Regular.ttf
    cd proportional
    nerd-font-patcher NeoSpleen-Regular.ttf \
      --complete \
      --careful \
      --outputdir .
    cd ..

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype
    install -Dm644 mono/NeoSpleenNerdFontMono-Regular.ttf $out/share/fonts/truetype/
    install -Dm644 proportional/NeoSpleenNerdFont-Regular.ttf $out/share/fonts/truetype/

    runHook postInstall
  '';

  meta = with lib; {
    description = "NeoSpleen Nerd Font - Spleen bitmap font with Nerd Font patches";
    homepage = "https://github.com/mbwilding/NeoSpleen";
    license = licenses.bsd2;
    platforms = platforms.all;
  };
}
