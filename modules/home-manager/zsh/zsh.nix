{ pkgs, lib, ... }:

{
  imports = [
    ./fastfetch.nix
    ./tmux.nix
    ../oh-my-posh
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
      	  bindkey "$terminfo[kcuu1]" history-substring-search-up
      	  bindkey "$terminfo[kcud1]" history-substring-search-down
      	'';
  };
}
