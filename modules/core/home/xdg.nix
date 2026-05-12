{ self, lib, ... }:
{
  flake.modules.homeManager = {
    core.imports = [ self.modules.homeManager.xdg ];

    xdg =
      { config, pkgs, ... }:

      let
        allMimeTypes = builtins.readFile "${pkgs.shared-mime-info}/share/mime/types";

        expandMimeGlobExcluding =
          glob: exclude:
          let
            globPrefix = lib.removeSuffix "*" glob;
            matchesGlob = mime: lib.hasPrefix globPrefix mime;
            isNotExcluded = mime: !(builtins.elem mime exclude);
          in
          allMimeTypes
          |> lib.splitString "\n"
          |> builtins.filter matchesGlob
          |> builtins.filter isNotExcluded;

        toMimeAttrs =
          formats: opener:
          formats
          |> map (n: {
            name = n;
            value = opener;
          })
          |> builtins.listToAttrs;

        entries = {
          browser = "zen-twilight.desktop";
          imageViewer = "imv.desktop";
          gimp = "gimp.desktop";
          videoViewer = "mpv.desktop";
          textEditor = "editor.desktop";
        };

        formats = rec {
          gimp = [
            "image/x-xcf"
            "image/x-psd"
            "image/x-xcfgz"
          ];

          browser = [
            "application/xhtml+xml"
            "application/pdf"
            "application/xml"

          ];

          textEditor = [
            "application/json"
            "application/yaml"
          ]
          ++ text;

          image = expandMimeGlobExcluding "image/*" gimp;
          video = expandMimeGlobExcluding "video/*" [ ];
          text = expandMimeGlobExcluding "text/*" [ ];
          audio = expandMimeGlobExcluding "audio/*" [ ];
        };

      in
      let
        dirs = config.xdg.userDirs;
      in
      {
        home.sessionVariables = {
          XDG_DESKTOP_DIR = dirs.desktop;
          XDG_DOWNLOAD_DIR = dirs.download;
          XDG_PICTURES_DIR = dirs.pictures;
          XDG_VIDEOS_DIR = dirs.videos;
          XDG_DOCUMENTS_DIR = dirs.documents;

          XDG_SCREENSHOTS_DIR = dirs.extraConfig.SCREENSHOTS;
          XDG_RECORDINGS_DIR = dirs.extraConfig.RECORDINGS;
        };

        xdg = {
          enable = true;

          userDirs = {
            enable = true;
            music = lib.mkDefault null;

            templates = null;
            publicShare = null;

            extraConfig = {
              SCREENSHOTS = "${dirs.pictures}/Screenshots";
              RECORDINGS = "${dirs.videos}/Recordings";
            };
          };

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
              exec = "${config.home.sessionVariables.EDITOR or (lib.getExe pkgs.helix)} %f";
              noDisplay = true;
            };
          };

          mimeApps = {
            enable = true;
            defaultApplications = lib.mkMerge [
              (toMimeAttrs formats.image entries.imageViewer)
              (toMimeAttrs formats.gimp entries.gimp)
              (toMimeAttrs formats.video entries.videoViewer)
              (toMimeAttrs formats.audio entries.videoViewer)
              (toMimeAttrs formats.textEditor entries.textEditor)
              (toMimeAttrs formats.browser entries.browser)
            ];
          };
        };
      };
  };
}
