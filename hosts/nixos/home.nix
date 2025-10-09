{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  imports = [
    ../../modules/home-manager/hyprland/hyprland.nix
    ../../modules/home-manager/gaming.nix
    ../../modules/home-manager/zsh/zsh.nix
  ];

  home.username = "daci";
  home.homeDirectory = "/home/daci";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
	fastfetch
	lazydocker
  ];

  home.file = {
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };
 
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  gtk = {
	  enable = true;
	  cursorTheme = {
		  name = "Bibata-Modern-Classic";
		  package = pkgs.bibata-cursors;
		  size = 24;
	  };
  };
  home.pointerCursor = {
	  gtk.enable = true;
	  package = pkgs.bibata-cursors;
	  name = "Bibata-Modern-Classic";
	  size = 24;
  };
  
  home.sessionVariables = {
	NIXOS_OZONE_WL = "1";
  };
  home.file.".local/share/flatpak/overrides/global".text = ''
	  [Context]
	  filesystems=/nix/store:ro;
  '';
}
