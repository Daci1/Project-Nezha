{ stablePkgs, pkgs, ... }:

let
  jb-nvim = stablePkgs.vimUtils.buildVimPlugin {
    name = "vim-NeoDebug";
    src = stablePkgs.fetchFromGitHub {
      "owner" = "nickkadutskyi";
      "repo" = "jb.nvim";
      "rev" = "a6bb6c196197462f1a2a569ffbe6b4da19e4994d";
      "hash" = "sha256-Zxt3KaIH2CzUVqTlf4rJU8iwyKUu5/YD4NwipFicvPM=";
    };
  };
in
{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    vimAlias = true;
    plugins = with stablePkgs.vimPlugins; [
      telescope-nvim
      jb-nvim
      undotree
      vim-fugitive
      comment-nvim

      lazygit-nvim
      gitsigns-nvim

      copilot-lua
      nui-nvim
      plenary-nvim
      render-markdown-nvim
      avante-nvim

      noice-nvim
      nvim-notify
      lualine-nvim

      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-cmdline
      cmp-dap

      nvim-dap
      nvim-dap-ui
      nvim-dap-view
      nvim-dap-go
      nvim-dap-vscode-js

      nvim-test

      auto-save-nvim
      conform-nvim

      # For other grammars: https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/tools/parsing/tree-sitter/update.nix
      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          go
          nix
          lua
          javascript
          typescript
          html
          css
          markdown
          json
          yaml
          toml
          bash
        ]
      ))
    ];

    extraConfig = ''
      			:luafile ~/.config/nvim/lua/init.lua
      		'';
  };

  home.sessionVariables = {
    NIX_NVIM_JS_DEBUG_PATH = "${pkgs.vscode-js-debug}/lib/node_modules/js-debug/dist/src/dapDebugServer.js";
  };

  home.packages = with pkgs; [
    ripgrep
    fzf

    gopls
    vscode-json-languageserver
    stablePkgs.go
    stablePkgs.delve

    stablePkgs.nodejs_24
    stablePkgs.typescript
    stablePkgs.typescript-language-server
    stablePkgs.angular-language-server
    vscode-js-debug

    # formatters and linters
    nixfmt
    stylua
  ];

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };

}
