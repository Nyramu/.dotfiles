{ config, lib, inputs, ... }: with lib;

let
  cfg = config.nyra.home.apps.editors;
in {
  imports = [inputs.nvf.homeManagerModules.default];

  options.nyra.home.apps.editors.nvf = {
    enable = mkEnableOption "nvf";
  };

  config = {
    programs.nvf = {
      enable = cfg.nvf.enable;
      settings = {
        vim.vimAlias = true;
        vim.lsp = {
          enable = true;
          formatOnSave = false;
          inlayHints.enable = true;
          lightbulb.enable = true;
          lspSignature.enable = true;
        };
        vim.languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;
          nix = {
            enable = true;
            format.type = "alejandra";
            extraDiagnostics.types = ["deadnix"];
          };
          #sql.enable = true;
          #clang.enable = true;
          #python.enable = true;
          #markdown.enable = true;
          #html.enable = true;
          #php.enable = true;
          #ts.enable = true;
          #go.enable = true;
          #lua.enable = true;
        };
        vim.options = {
          scrolloff = 8;
          tabstop = 2;
          shiftwidth = 2;
          wrap = true;
          splitbelow = true;
          splitright = true;
          termguicolors = true;
          cmdheight = 0;
        };
      };
    };
  };
}
