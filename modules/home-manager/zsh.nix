{ pkgs, lib, ... }:

{
  programs.zsh = {
	enable = true;
	history = {
	  save = 1000;
	  size = 1000;
	};
        historySubstringSearch = {
	    enable = true;
	};
	enableCompletion = true;
	initContent = ''
	  bindkey -e
	  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
	'';
  };
}
