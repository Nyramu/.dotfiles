{ lib, ... }:
{
  flake.modules.homeManager.helix =
    { pkgs, ... }:
    {
      programs.helix = {
        languages = {
          language-server = {
            nixd.command = "${lib.getExe pkgs.nixd}";
            nil.command = "${lib.getExe pkgs.nil}";
            bash-language-server.command = "${lib.getExe pkgs.bash-language-server}";
            # clangd.command = "${pkgs.clang-tools}/bin/clangd";
            # cmake-language-server.command = "${lib.getExe pkgs.cmake-language-server}";
            # csharp-ls.command = "${lib.getExe pkgs.csharp-ls}";
            #kotlin-language-server.command = "${getExe pkgs.kotlin-language-server}";
            gopls.command = "${lib.getExe pkgs.gopls}";
            intelephense.command = "${lib.getExe pkgs.intelephense}"; # PHP
            superhtml.command = "${lib.getExe pkgs.superhtml}";
            markdown-oxide.command = "${lib.getExe pkgs.markdown-oxide}";
            vscode-css-language-server.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server";
            vscode-json-language-server.command = "${pkgs.vscode-langservers-extracted}/bin/vscode-json-language-server";
            tombi.command = "{lib.getExe pkgs.tombi}"; # TOML
            yaml-language-server.command = "{lib.getExe pkgs.yaml-language-server}";
            # typescript-language-server = {
            #   command = "${lib.getExe pkgs.typescript-language-server}";
            #   config = {
            #     typescript.inlayHints = {
            #       includeInlayEnumMemberValueHints = true;
            #       includeInlayFunctionLikeReturnTypeHints = false;
            #       includeInlayFunctionParameterTypeHints = false;
            #       includeInlayParameterNameHints = "literals";
            #       includeInlayParameterNameHintsWhenArgumentMatchesName = true;
            #       includeInlayPropertyDeclarationTypeHints = false;
            #       includeInlayVariableTypeHints = true;
            #     };
            #   };
            # };
          };

          language = [
            {
              name = "nix";
              file-types = [ "nix" ];
              formatter.command = "${lib.getExe pkgs.nixfmt}";
            }
            {
              name = "markdown";
              file-types = [
                "md"
                "MD"
              ];
              formatter = {
                command = "${lib.getExe pkgs.deno}";
                args = [
                  "fmt"
                  "-"
                  "--ext"
                  "md"
                ];
              };
            }
          ];
        };
      };
    };
}
