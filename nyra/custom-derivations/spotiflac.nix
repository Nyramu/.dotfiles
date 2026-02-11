{
  fetchurl,
  appimageTools,
  webkitgtk_4_1,
  gtk3,
}:
let
  pname = "spotiflac";
  version = "7.0.9";

  src = fetchurl {
    url = "https://github.com/afkarxyz/SpotiFLAC/releases/download/v${version}/SpotiFLAC.AppImage";
    hash = "sha256-GVNRMXr8rwiuksU7oKiOPrDDEiQdJinWO139IFXkkfw=";
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
