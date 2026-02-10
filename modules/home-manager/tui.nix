{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lazydocker
  ];

  programs.lazygit = {
    enable = true;
    settings = {
      os.edit = "nvim --server $NVIM_LISTEN_ADDRESS --remote {{filename}}; tmux kill-window";
    };
  };

}
