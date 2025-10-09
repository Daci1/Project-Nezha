{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    oh-my-posh
  ];

  programs.zsh = {
	enable = true;
	history = {
	  save = 1000;
	  size = 1000;
   	  share = true;
	};
        historySubstringSearch = {
	    enable = true;
	};
	enableCompletion = true;
	initContent = ''
	  bindkey -e
	  zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
	  eval "$(${pkgs.oh-my-posh}/bin/oh-my-posh init zsh --config ${./custom.omp.json})"
	  bindkey "$terminfo[kcuu1]" history-substring-search-up
	  bindkey "$terminfo[kcud1]" history-substring-search-down
	'';
  };

  #programs.oh-my-posh = {
	#enable = true;
	#enableZshIntegration = true;
  #};	settings = builtins.fromJSON (builtins.readFile ./custom.omp.json);
}
