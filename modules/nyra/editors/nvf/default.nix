{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.modules.homeManager = {
    editors.imports = [ self.modules.homeManager.nvf ];

    nvf =
      { config, wayland, ... }:

      let
        cfg = config.nyra.editors.nvf;
        default = config.nyra.editors.default;
      in
      {
        imports = [ inputs.nvf.homeManagerModules.nvf ];

        options.nyra.editors.nvf = {
          enable = lib.mkEnableOption "nvf";
        };

        config = {
          programs.nvf = lib.mkIf (cfg.enable) {
            enable = true;
            enableManpages = true;
            defaultEditor = (default == "nvf");
            settings = {
              vim = {
                autocomplete = {
                  blink-cmp = {
                    enable = true;
                    friendly-snippets.enable = true;
                  };
                  # nvim-cmp = {
                  #   enable = true;
                  # };
                };
                autopairs = {
                  nvim-autopairs.enable = true;
                };
                binds = {
                  cheatsheet.enable = true;
                  # hardtime-nvim.enable = true;
                  whichKey.enable = true;
                };
                clipboard = {
                  enable = true;
                  providers.wl-copy.enable = wayland.enable;
                  providers.xclip.enable = true;
                };
                comments = {
                  comment-nvim = {
                    enable = true;
                    mappings.toggleCurrentLine = "C-c";
                  };
                };
                dashboard = {
                  alpha = {
                    enable = true;
                    # layout = [ ];
                    # opts = { };
                    # theme = "";
                  };
                  dashboard-nvim = {
                    enable = true;
                  };
                  # startify = {
                  #   enable = true;
                  #   bookmarks = [
                  #     { d = user.dotfiles; }
                  #   ];
                  #   changeDirCmd = "cd";
                  #   changeToVCRoot = true;
                  #   customHeader = [ "palle" ];
                  # };
                };
                diagnostics = {
                  enable = true;
                  nvim-lint = {
                    enable = true;
                  };
                  presets = {
                    biomejs.enable = true;
                    deadnix.enable = true;
                  };
                };
                # extraPlugins = { };
                filetree = {
                  neo-tree = {
                    enable = true;
                  };
                };
                formatter = {
                  conform-nvim = {
                    enable = true;
                  };
                };
                gestures = {
                  gesture-nvim = {
                    enable = true;
                  };
                };
                git = {
                  enable = true;
                  git-conflict = {
                    enable = true;
                  };
                  gitsigns = {
                    enable = true;
                  };
                };
                # highlight = {};
                # keymaps = [];
                languages = {
                  enableDAP = true;
                  enableExtraDiagnostics = true;
                  enableFormat = true;
                  enableTreesitter = true;
                  bash = {
                    enable = true;
                  };
                  clang = {
                    enable = true;
                  };
                  cmake = {
                    enable = true;
                  };
                  # csharp = {};
                  css = {
                    enable = true;
                  };
                  go = {
                    enable = true;
                  };
                  html = {
                    enable = true;
                  };
                  # java = {
                  #   enable = true;
                  #   # extensions = {
                  #   #   gradle-nvim.enable = true;
                  #   #   maven-nvim.enable = true;
                  #   # };
                  # };
                  json = {
                    enable = true;
                  };
                  kotlin = {
                    enable = true;
                  };
                  lua = {
                    enable = true;
                  };
                  markdown = {
                    enable = true;
                    extensions = {
                      markview-nvim.enable = true;
                    };
                  };
                  nix = {
                    enable = true;
                    format.type = [ "nixfmt" ];
                  };
                  php = {
                    enable = true;
                  };
                  python = {
                    enable = true;
                  };
                  qml = {
                    enable = true;
                  };
                  sql = {
                    enable = true;
                  };
                  toml = {
                    enable = true;
                  };
                  xml = {
                    enable = true;
                  };
                  yaml = {
                    enable = true;
                  };
                };
                lsp = {
                  enable = true;
                  formatOnSave = true;
                  inlayHints.enable = true;
                  # lightbulb = {};
                  presets = {
                    bash-language-server.enable = true;
                    gopls.enable = true;
                    intelephense.enable = true;
                    kotlin-language-server.enable = true;
                    lua-language-server.enable = true;
                    markdown-oxide.enable = true;
                    nixd.enable = true;
                    sqls.enable = true;
                    superhtml.enable = true;
                    tombi.enable = true;
                    vscode-css-language-server.enable = true;
                    vscode-json-language-server.enable = true;
                    yaml-language-server.enable = true;
                  };

                  # servers = {};
                };
                options = {
                  wrap = true;
                };
                ui = {
                  nvim-highlight-colors = {
                    enable = true;
                    setupOpts = {
                      render = "background";
                      virtual_symbol_position = "inline";
                    };
                  };
                };
              };
            };
          };

          nyra.editors.nvf.enable = lib.mkDefault (default == "nvf");
        };
      };
  };
}
