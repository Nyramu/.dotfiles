{ config, lib, pkgs, ... }:

  let
    defaultBrowser = config.nyra.home.apps.defaultBrowser;
  in
{
  defaultApplications = let
    allMimeTypes = builtins.readFile "${pkgs.shared-mime-info}/share/mime/types";

    expandMimeGlobExcluding = glob: exclude: let
      globPrefix = lib.removeSuffix "*" glob;
      matchesGlob = mime: lib.hasPrefix globPrefix mime;
      isNotExcluded = mime: !(builtins.elem mime exclude);
    in
      allMimeTypes
      |> lib.splitString "\n"
      |> builtins.filter matchesGlob
      |> builtins.filter isNotExcluded;

    browser = "${defaultBrowser}.desktop";
    imageViewer = "imv.desktop";
    gimp = "gimp.desktop";
    videoViewer = "mpv.desktop";
    textEditor = "editor.desktop";

    gimpFormats = ["image/x-xcf" "image/x-psd" "image/x-xcfgz"];
    browserFormats = ["application/xhtml+xml" "application/pdf" "application/xml"];

    imageFormats = expandMimeGlobExcluding "image/*" gimpFormats;
    videoFormats = expandMimeGlobExcluding "video/*" [];
    textFormats = expandMimeGlobExcluding "text/*" [];
    audioFormats = expandMimeGlobExcluding "audio/*" [];

    toMimeAttrs = formats: opener:
      formats
      |> map (n: {
        name = n;
        value = opener;
      })
      |> builtins.listToAttrs;
  in
    lib.mkMerge [
      (toMimeAttrs imageFormats imageViewer)
      (toMimeAttrs gimpFormats gimp)
      (toMimeAttrs videoFormats videoViewer)
      (toMimeAttrs audioFormats videoViewer)
      (toMimeAttrs textFormats textEditor)
      (toMimeAttrs browserFormats browser)
    ];

  desktopEntries = {
    imv = {
      name = "imv";
      exec = "${lib.getExe pkgs.imv}";
      noDisplay = true;
    };
    mpv = {
      name = "mpv";
      exec = "${lib.getExe pkgs.mpv} --vo=gpu --keep-open=yes";
      noDisplay = true;
    };
    editor = {
      name = "Text Editor";
      exec = "${config.home.sessionVariables.EDITOR or (lib.getExe pkgs.nvim)} %f";
      noDisplay = true;
    };
  };
}
