{ pkgs, ... }:

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

      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp

      # For other grammars: https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/tools/parsing/tree-sitter/update.nix
      (nvim-treesitter.withPlugins (plugins: with plugins; [
        go
        nix
        lua
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
	];

	xdg.configFile.nvim = {
		source = ./config;
		recursive = true;
	};

}

