{ stablePkgs, pkgs, ... }:

let
  jb-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "vim-NeoDebug";
    src = pkgs.fetchFromGitHub {
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
		plugins = with pkgs.vimPlugins; [
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

      nvim-dap
      nvim-dap-ui
      nvim-dap-view
      cmp-dap
      nvim-dap-go
      nvim-dap-vscode-js

      nvim-test

      # For other grammars: https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/tools/parsing/tree-sitter/update.nix
      (nvim-treesitter.withPlugins (plugins: with plugins; [
        go
        nix
        lua
        javascript typescript html css markdown
        json yaml toml
        bash
      ]))
		];

		extraConfig = ''
			:luafile ~/.config/nvim/lua/init.lua
			'';
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
	];

	xdg.configFile.nvim = {
		source = ./config;
		recursive = true;
	};

}

