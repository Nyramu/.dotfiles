{ self, lib, ... }:
{
  flake.modules.homeManager = {
    core.imports = [ self.modules.homeManager.xdg ];

    xdg =
      { config, pkgs, ... }:

      let
        gaming = config.nyra.gaming;
        mpd = config.nyra.music.mpd;

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
      {
        xdg =
          let
            dirs = config.xdg.userDirs;
          in
          {
            enable = true;

            userDirs = {
              templates = null;
              publicShare = null;

              extraConfig = {
                SCREENSHOTS = "${dirs.pictures}/Screenshots";
                RECORDINGS = "${dirs.videos}/Recordings";
              }
              // lib.optionalAttrs (mpd.enable) {
                LYRICS = "${dirs.music}/Lyrics";
                PLAYLISTS = "${dirs.music}/Playlists";
              }
              // lib.optionalAttrs (lib.any (x: x.enable) (lib.attrValues gaming)) {
                GAMES = "${config.home.homeDirectory}/Games";
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
