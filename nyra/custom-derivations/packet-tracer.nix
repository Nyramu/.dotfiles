{
  lib,
  stdenvNoCC,
  fetchurl,
  autoPatchelfHook,
  makeWrapper,
  appimageTools,
  alsa-lib,
  binutils,
  brotli,
  dbus,
  expat,
  fontconfig,
  freetype,
  glib,
  harfbuzz,
  libdrm,
  libglvnd,
  libpulseaudio,
  libudev0-shim,
  libxkbcommon,
  libxkbfile,
  mesa,
  nspr,
  nss,
  stdenv,
  wayland,
  xorg,
  zlib,
  buildFHSEnv,
  copyDesktopItems,
  makeDesktopItem,
  version ? "9.0.0",
  packetTracerSource ? null,
}: let
  pname = "ciscoPacketTracer9";

  src =
    if (packetTracerSource != null)
    then packetTracerSource
    else
      fetchurl {
        url = "https://archive.org/download/packettracer900/CiscoPacketTracer_900_Ubuntu_64bit.deb";
        hash = "sha256-3ZrA1Mf8N9y2j2J/18fm+m1CAMFEklJuVhi5vRcu2SA=";
      };

  appimage = stdenvNoCC.mkDerivation {
    name = "${pname}-${version}-appimage";
    inherit src;

    nativeBuildInputs = [binutils];

    unpackPhase = ''
      ar x $src
      tar xf data.tar.*
    '';

    installPhase = ''
      mkdir -p $out
      cp opt/pt/packettracer.AppImage $out/packettracer.AppImage
    '';
  };

  appimageContents = appimageTools.extract {
    inherit pname version;
    src = "${appimage}/packettracer.AppImage";
  };

  unwrapped = stdenvNoCC.mkDerivation rec {
    name = "${pname}-unwrapped";
    inherit version;

    src = appimageContents;

    nativeBuildInputs = [
      autoPatchelfHook
      makeWrapper
    ];

    buildInputs =
      [
        alsa-lib
        brotli
        dbus
        expat
        fontconfig
        freetype
        glib
        harfbuzz
        libdrm
        libglvnd
        libpulseaudio
        libudev0-shim
        libxkbcommon
        libxkbfile
        mesa
        nspr
        nss
        stdenv.cc.cc.lib
        wayland
        zlib
      ]
      ++ (with xorg; [
        libICE
        libSM
        libX11
        libXcomposite
        libXcursor
        libXdamage
        libXext
        libXfixes
        libXi
        libXrandr
        libXrender
        libXtst
        libxcb
        xcbutilimage
        xcbutilkeysyms
        xcbutilrenderutil
        xcbutilwm
      ]);

    autoPatchelfIgnoreMissingDeps = [
      "libQt6UiTools.so.6"
      "libmtdev.so.1"
      "libts.so.0"
      "libinput.so.10"
    ];

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share
      cp -r . $out/share/

      makeWrapper "$out/share/opt/pt/bin/PacketTracer" "$out/bin/packettracer9" \
        --prefix LD_LIBRARY_PATH : "$out/share/opt/pt/bin:$out/share/usr/lib:${lib.makeLibraryPath buildInputs}" \
        --chdir "$out/share/opt/pt/bin"

      runHook postInstall
    '';

    postFixup = ''
      if [ -f $out/share/opt/pt/CiscoPacketTracer-9.0.0.desktop ]; then
        substituteInPlace $out/share/opt/pt/CiscoPacketTracer-9.0.0.desktop \
          --replace "@EXEC_PATH@" "$out/bin/packettracer9"
      fi
    '';
  };

  fhs-env = buildFHSEnv {
    name = "${pname}-fhs-env";
    runScript = lib.getExe' unwrapped "packettracer9";
    targetPkgs = pkgs: [
      libudev0-shim
      pkgs.stdenv.cc.cc.lib
    ];
  };
in
  stdenvNoCC.mkDerivation {
    inherit pname version;

    dontUnpack = true;

    nativeBuildInputs = [
      copyDesktopItems
    ];

    installPhase = ''
      runHook preInstall

      mkdir -p $out/bin
      ln -s ${fhs-env}/bin/${fhs-env.name} $out/bin/packettracer9

      mkdir -p $out/share/icons/hicolor/48x48/apps
      if [ -f ${unwrapped}/opt/pt/app.png ]; then
        ln -s ${unwrapped}/opt/pt/app.png $out/share/icons/hicolor/48x48/apps/cisco-packet-tracer-9.png
      fi

      runHook postInstall
    '';

    desktopItems = [
      (makeDesktopItem {
        name = "cisco-pt9.desktop";
        desktopName = "Cisco Packet Tracer 9";
        icon = "cisco-packet-tracer-9";
        exec = "packettracer9 %f";
        mimeTypes = [
          "application/x-pkt"
          "application/x-pka"
          "application/x-pkz"
          "application/x-pksz"
          "application/x-pks"
        ];
        categories = ["Education"];
      })
    ];

    meta = {
      description = "Network simulation tool from Cisco";
      homepage = "https://www.netacad.com/courses/packet-tracer";
      license = lib.licenses.unfree;
      mainProgram = "packettracer9";
      platforms = ["x86_64-linux"];
      sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
    };
  }
