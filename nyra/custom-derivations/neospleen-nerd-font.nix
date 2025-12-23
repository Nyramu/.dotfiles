{ lib, stdenvNoCC, fetchurl }:

stdenvNoCC.mkDerivation rec {
  pname = "neospleen-nerd-font";
  version = "1.0.62";

  src = fetchurl {
    url = "https://github.com/mbwilding/NeoSpleen/releases/download/${version}/NeoSpleenNerdFont-Regular.ttf";
    sha256 = "sha256-JYivzytGCmEcnu0Nv3AgfIhBFwIJzAcJFSudJ0Bj/VM=";
  };

  dontUnpack = true;

  installPhase = ''
    runHook preInstall
    
    install -Dm644 $src $out/share/fonts/truetype/NeoSpleenNerdFont-Regular.ttf
    
    runHook postInstall
  '';

  meta = with lib; {
    description = "NeoSpleen Nerd Font - Spleen bitmap font with Nerd Font patches";
    homepage = "https://github.com/mbwilding/NeoSpleen";
    license = licenses.bsd2;
    platforms = platforms.all;
  };
}
