{ pkgs, inputs, ... }:

{
  imports = [ inputs.nvf.homeManagerModules.default ];
  
  programs.nvf = {
    enable = true;
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
}
