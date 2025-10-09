{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  imports = [
    ../../modules/home-manager/hyprland.nix
    ../../modules/home-manager/gaming.nix
    ../../modules/home-manager/zsh/zsh.nix
  ];

  home.username = "daci";
  home.homeDirectory = "/home/daci";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
	fastfetch
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };
 
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
