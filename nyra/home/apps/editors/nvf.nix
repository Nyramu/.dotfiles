{ config, lib, pkgs, inputs, ... }: with lib;

let
  cfg = config.nyra.home.apps.editors;
in
{
  imports = [ inputs.nvf.homeManagerModules.default ];
  
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
	  formatOnSave = true;
	  inlayHints.enable = true;
	  lightbulb.enable = true;
	  lspSignature.enable = true;
        };
      };
    };
  };
}
