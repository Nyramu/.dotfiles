{
  fetchurl,
  appimageTools,
  webkitgtk_4_1,
  gtk3,
}:
let
  pname = "spotiflac";
  version = "7.1.6";

  src = fetchurl {
    url = "https://github.com/spotbye/SpotiFLAC/releases/download/v${version}/SpotiFLAC.AppImage";
    hash = "sha256-ryvDz1rdHYb1/G9j0L/eJ4vlkFZGiUPU8HGx+sLSqP0=";
  };

  appimageContents = appimageTools.extractType2 { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs = pkgs: [
    webkitgtk_4_1
    gtk3
  ];

  extraInstallCommands = ''
    install -Dm444 ${appimageContents}/spotiflac.desktop -t $out/share/applications
    install -Dm444 ${appimageContents}/spotiflac.png $out/share/pixmaps/spotiflac.png

    substituteInPlace $out/share/applications/spotiflac.desktop \
    --replace-fail 'Exec=SpotiFLAC' 'Exec=${pname}'
  '';
}
